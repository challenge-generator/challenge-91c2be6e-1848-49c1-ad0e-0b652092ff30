terraform {
  required_version = ">= 1.7.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

# ============================================================================
# CONFIGURACIÓN DE RED Y SEGURIDAD
# ============================================================================

# VPC principal donde se desplegarán todos los recursos
data "aws_vpc" "main" {
  default = var.vpc_id == "" ? true : false
  id      = var.vpc_id != "" ? var.vpc_id : null
}

# Subnets públicas para el ALB
data "aws_subnets" "public" {
  filter {
    name   = "vpc-id"
    values = [data.aws_vpc.main.id]
  }
  tags = {
    Type = "public"
  }
}

# Subnets privadas para ECS y RDS
data "aws_subnets" "private" {
  filter {
    name   = "vpc-id"
    values = [data.aws_vpc.main.id]
  }
  tags = {
    Type = "private"
  }
}

# Security group para el cluster ECS
resource "aws_security_group" "ecs" {
  name        = "${var.project}-${var.environment}-ecs-sg"
  description = "Security group para el cluster ECS de Tomcat"
  vpc_id      = data.aws_vpc.main.id

  ingress {
    from_port   = 8080
    to_port     = 8080
    protocol    = "tcp"
    cidr_blocks = [data.aws_vpc.main.cidr_block]
    description = "HTTP traffic from ALB"
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
    description = "Allow all outbound"
  }

  tags = {
    Name        = "${var.project}-${var.environment}-ecs-sg"
    Environment = var.environment
    Project     = var.project
  }
}

# Security group para RDS
resource "aws_security_group" "rds" {
  name        = "${var.project}-${var.environment}-rds-sg"
  description = "Security group para la base de datos RDS"
  vpc_id      = data.aws_vpc.main.id

  ingress {
    from_port       = 5432
    to_port         = 5432
    protocol        = "tcp"
    security_groups = [aws_security_group.ecs.id]
    description     = "PostgreSQL traffic from ECS"
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
    description = "Allow all outbound"
  }

  tags = {
    Name        = "${var.project}-${var.environment}-rds-sg"
    Environment = var.environment
    Project     = var.project
  }
}

# Security group para el ALB
resource "aws_security_group" "alb" {
  name        = "${var.project}-${var.environment}-alb-sg"
  description = "Security group para el Application Load Balancer"
  vpc_id      = data.aws_vpc.main.id

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    description = "HTTP from internet"
  }

  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    description = "HTTPS from internet"
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
    description = "Allow all outbound"
  }

  tags = {
    Name        = "${var.project}-${var.environment}-alb-sg"
    Environment = var.environment
    Project     = var.project
  }
}

# ============================================================================
# CLUSTER ECS CON FARGATE PARA TOMCAT
# ============================================================================

module "tomcat_cluster" {
  source = "./modules/tomcat-cluster"

  cluster_name           = "${var.project}-tomcat-${var.environment}"
  environment            = var.environment
  project                = var.project
  vpc_id                 = data.aws_vpc.main.id
  subnet_ids             = data.aws_subnets.private.ids
  security_group_ids     = [aws_security_group.ecs.id]
  container_image        = var.tomcat_image
  container_port         = var.tomcat_container_port
  desired_count          = var.ecs_desired_count
  max_capacity           = var.ecs_max_capacity
  min_capacity           = var.ecs_min_capacity
  cpu_threshold          = var.ecs_cpu_threshold
  memory_threshold       = var.ecs_memory_threshold
  alb_target_group_arn   = module.load_balancer.target_group_arns[0]
  alb_security_groups    = [aws_security_group.alb.id]
}

# ============================================================================
# BASE DE DATOS RDS POSTGRESQL
# ============================================================================

module "rds_postgresql" {
  source = "./modules/rds-postgresql"

  identifier     = "${var.project}-${var.environment}-db"
  environment    = var.environment
  project        = var.project
  engine         = "postgres"
  engine_version = var.rds_engine_version
  instance_class = var.rds_instance_class
  allocated_storage     = var.rds_allocated_storage
  storage_encrypted     = var.rds_storage_encrypted
  multi_az              = var.rds_multi_az
  db_name          = var.rds_db_name
  username        = var.rds_username
  password        = var.rds_password
  subnet_ids      = data.aws_subnets.private.ids
  security_group_ids = [aws_security_group.rds.id]
  backup_retention_period = var.rds_backup_retention
  skip_final_snapshot     = var.environment != "prod"
  deletion_protection     = var.environment == "prod"
  maintenance_window      = var.rds_maintenance_window
  backup_window           = var.rds_backup_window
}

# ============================================================================
# APPLICATION LOAD BALANCER
# ============================================================================

module "load_balancer" {
  source = "./modules/load-balancer"

  name           = "${var.project}-${var.environment}-alb"
  environment    = var.environment
  project        = var.project
  vpc_id         = data.aws_vpc.main.id
  subnet_ids     = data.aws_subnets.public.ids
  security_groups = [aws_security_group.alb.id]

  enable_http2   = true
  idle_timeout   = 60

  target_groups = [{
    name                             = "tomcat-target-group"
    port                             = 8080
    protocol                         = "HTTP"
    path_pattern                     = ["/*"]
    health_check_path                = var.health_check_path
    health_check_interval            = 30
    health_check_timeout             = 5
    healthy_threshold_count          = 2
    unhealthy_threshold_count        = 3
    target_type                      = "ip"
  }]

  listeners = [{
    port            = 80
    protocol        = "HTTP"
    target_group_index = 0
  }]

  tags = {
    Name        = "${var.project}-${var.environment}-alb"
    Environment = var.environment
    Project     = var.project
  }
}

# ============================================================================
# MONITOREO CON CLOUDWATCH
# ============================================================================

module "monitoring" {
  source = "./modules/monitoring"

  environment        = var.environment
  project            = var.project
  alb_arn            = module.load_balancer.arn
  alb_name           = module.load_balancer.name
  ecs_cluster_name   = module.tomcat_cluster.cluster_name
  ecs_service_name   = module.tomcat_cluster.service_name
  rds_instance_id    = module.rds_postgresql.instance_id
  rds_endpoint       = module.rds_postgresql.endpoint

  # Alarmas para el ALB
  alb_target_response_time_threshold = var.alb_response_time_threshold
  alb_target_error_rate_threshold    = var.alb_error_rate_threshold
  alb_request_count_threshold        = var.alb_request_count_threshold

  # Alarmas para ECS
  ecs_cpu_utilization_threshold  = var.ecs_cpu_threshold
  ecs_memory_utilization_threshold = var.ecs_memory_threshold
  ecs_service_running_count_threshold = var.ecs_desired_count

  # Alarmas para RDS
  rds_cpu_utilization_threshold     = var.rds_cpu_threshold
  rds_storage_utilization_threshold = var.rds_storage_threshold
  rds_connections_threshold         = var.rds_connections_threshold

  # Alarmas para costos
  enable_cost_alarms = var.environment != "dev"
  monthly_budget_limit = var.monthly_budget

  notification_topic_arn = var.sns_topic_arn
}