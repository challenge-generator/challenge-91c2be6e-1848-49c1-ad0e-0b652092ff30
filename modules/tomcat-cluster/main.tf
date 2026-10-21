terraform {
  required_version = ">= 1.7"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

locals {
  name_prefix   = var.prefix != "" ? "${var.prefix}-${var.service_name}" : var.service_name
  common_tags = merge(
    var.common_tags,
    {
      Project     = var.project_name
      Environment = var.environment
      ManagedBy   = "terraform"
      Service     = var.service_name
    }
  )

  container_definitions = [
    {
      name      = var.service_name
      image     = var.container_image
      essential = true
      portMappings = [
        {
          containerPort = var.container_port
          protocol      = "tcp"
        }
      ]
      environment = concat(
        [
          { name = "JAVA_OPTS", value = var.java_opts },
          { name = "CATALINA_OPTS", value = var.catalina_opts },
          { name = "SERVER_PORT", value = tostring(var.container_port) },
          { name = "APP_ENV", value = var.environment }
        ],
        var.extra_environment
      )
      logConfiguration = {
        logDriver = "awslogs"
        options = {
          "awslogs-group"         = "/ecs/${local.name_prefix}"
          "awslogs-region"        = var.aws_region
          "awslogs-stream-prefix" = "ecs"
        }
      }
      healthCheck = {
        command     = ["CMD-SHELL", "curl -f http://localhost:${var.container_port}${var.health_check_path} || exit 1"]
        interval    = var.health_check_interval
        timeout     = var.health_check_timeout
        retries     = var.health_check_retries
        startPeriod = var.health_check_start_period
      }
      resources = {
        limits = {
          cpu    = var.task_cpu
          memory = var.task_memory
        }
        reservations = {
          cpu    = var.task_cpu_reservation
          memory = var.task_memory_reservation
        }
      }
    }
  ]
}

resource "aws_ecs_cluster" "this" {
  name = local.name_prefix

  setting {
    name  = "containerInsights"
    value = var.enable_container_insights ? "enabled" : "disabled"
  }

  configuration {
    execute_command_configuration {
      logging = "DEFAULT"
    }
  }

  tags = local.common_tags
}

resource "aws_ecs_cluster_capacity_providers" "this" {
  cluster = aws_ecs_cluster.this.name

  capacity_providers = ["FARGATE"]

  default_capacity_provider_strategy {
    capacity_provider = "FARGATE"
    base              = var.fargate_base_capacity
    weight            = var.fargate_weight
  }
}

resource "aws_ecs_task_definition" "this" {
  family                   = local.name_prefix
  network_mode             = "awsvpc"
  requires_compatibilities = ["FARGATE"]
  cpu                      = tostring(var.task_cpu)
  memory                   = tostring(var.task_memory)
  execution_role_arn       = aws_iam_role.ecs_execution_role.arn
  task_role_arn            = aws_iam_role.ecs_task_role.arn
  container_definitions    = jsonencode(local.container_definitions)

  runtime_platform {
    operating_system_family = "LINUX"
    cpu_architecture        = var.cpu_architecture
  }

  volume {
    name = "efs-volume"

    efs_volume_configuration {
      file_system_id          = var.efs_id
      root_directory          = var.efs_root_directory
      transit_encryption      = var.efs_transit_encryption
      access_point_id         = var.efs_access_point_id
      iam                     = var.efs_iam_authentication ? "ENABLED" : "DISABLED"
    }
  }

  tags = local.common_tags
}

resource "aws_iam_role" "ecs_execution_role" {
  name = "${local.name_prefix}-ecs-execution-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Principal = {
          Service = ["ecs-tasks.amazonaws.com"]
        }
      }
    ]
  })

  tags = local.common_tags
}

resource "aws_iam_role_policy_attachment" "ecs_execution_role_policy" {
  role       = aws_iam_role.ecs_execution_role.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonECSTaskExecutionRolePolicy"
}

resource "aws_iam_role_policy" "ecs_execution_role_secrets" {
  count = length(var.secrets) > 0 ? 1 : 0
  name  = "${local.name_prefix}-ecs-execution-secrets"
  role  = aws_iam_role.ecs_execution_role.id

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Action = [
          "secretsmanager:GetSecretValue",
          "ssm:GetParameters"
        ]
        Resource = var.secrets
      }
    ]
  })
}

resource "aws_iam_role" "ecs_task_role" {
  name = "${local.name_prefix}-ecs-task-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Principal = {
          Service = ["ecs-tasks.amazonaws.com"]
        }
      }
    ]
  })

  tags = local.common_tags
}

resource "aws_iam_role_policy" "ecs_task_role_policy" {
  count = length(var.task_policy_arns) > 0 ? 1 : 0
  name  = "${local.name_prefix}-ecs-task-policy"
  role  = aws_iam_role.ecs_task_role.id

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Action = ["sts:AssumeRole"]
        Resource = var.task_policy_arns
      }
    ]
  })
}

resource "aws_ecs_service" "this" {
  name            = local.name_prefix
  cluster         = aws_ecs_cluster.this.id
  task_definition = aws_ecs_task_definition.this.arn
  launch_type     = "FARGATE"
  platform_version = var.platform_version

  desired_count = var.desired_count

  deployment_configuration {
    minimum_healthy_percent = var.minimum_healthy_percent
    maximum_percent         = var.maximum_percent

    deployment_circuit_breaker {
      enable   = var.enable_circuit_breaker
      rollback = var.circuit_breaker_rollback
    }
  }

  network_configuration {
    subnets          = var.vpc_subnet_ids
    security_groups  = var.security_groups
    assign_public_ip = var.assign_public_ip
  }

  load_balancer {
    target_group_arn = var.target_group_arn
    container_name   = var.service_name
    container_port   = var.container_port
  }

  service_connect_configuration {
    enabled = var.enable_service_connect

    service {
      discovery_name = var.service_name
      port_name      = "${var.service_name}-port"

      client_alias {
        dns_name = var.service_name
        port     = var.container_port
      }
    }
  }

  lifecycle {
    ignore_changes = [desired_count]
  }

  tags = local.common_tags
}

resource "aws_appautoscaling_target" "ecs_target" {
  min_capacity = var.min_capacity
  max_capacity = var.max_capacity

  role_arn = aws_iam_role.autoscaling_role.arn

  scalable_dimension = "ecs:service:DesiredCount"
  resource_id         = "service/${aws_ecs_cluster.this.name}/${aws_ecs_service.this.name}"
  service_namespace   = "ecs"
}

resource "aws_appautoscaling_policy" "cpu_scaling" {
  name               = "${local.name_prefix}-cpu-scaling"
  scaling_target_id = aws_appautoscaling_target.ecs_target.id

  policy_type = "TargetTrackingScaling"

  target_tracking_scaling_policy_configuration {
    predefined_metric_specification {
      predefined_metric_type = "ECSServiceAverageCPUUtilization"
    }

    target_value       = var.cpu_target_value
    scale_in_cooldown  = var.scale_in_cooldown
    scale_out_cooldown = var.scale_out_cooldown
  }
}

resource "aws_appautoscaling_policy" "memory_scaling" {
  name               = "${local.name_prefix}-memory-scaling"
  scaling_target_id = aws_appautoscaling_target.ecs_target.id

  policy_type = "TargetTrackingScaling"

  target_tracking_scaling_policy_configuration {
    predefined_metric_specification {
      predefined_metric_type = "ECSServiceAverageMemoryUtilization"
    }

    target_value       = var.memory_target_value
    scale_in_cooldown  = var.scale_in_cooldown
    scale_out_cooldown = var.scale_out_cooldown
  }
}

resource "aws_iam_role" "autoscaling_role" {
  name = "${local.name_prefix}-autoscaling-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Principal = {
          Service = ["application-autoscaling.amazonaws.com"]
        }
      }
    ]
  })

  tags = local.common_tags
}

resource "aws_iam_role_policy_attachment" "autoscaling_policy" {
  role       = aws_iam_role.autoscaling_role.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonEC2ContainerServiceAutoscaleRole"
}

resource "aws_cloudwatch_log_group" "this" {
  name              = "/ecs/${local.name_prefix}"
  retention_in_days = var.log_retention_days

  tags = local.common_tags
}

resource "aws_security_group" "ecs_tasks" {
  name        = "${local.name_prefix}-tasks-sg"
  description = "Security group for ECS tasks"
  vpc_id      = var.vpc_id

  ingress {
    from_port   = var.container_port
    to_port     = var.container_port
    protocol    = "tcp"
    security_groups = var.allowed_security_groups
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = local.common_tags
}

resource "aws_security_group_rule" "alb_to_ecs" {
  type                     = "ingress"
  from_port                = var.container_port
  to_port                  = var.container_port
  protocol                 = "tcp"
  source_security_group_id = var.alb_security_group_id
  security_group_id        = aws_security_group.ecs_tasks.id
  description              = "Allow traffic from ALB to ECS tasks"
}