locals {
  # Nombre del balanceador de carga derivado del ambiente
  lb_name = var.lb_name != "" ? var.lb_name : "${var.environment}-app-lb"

  # Configuracion de tags comunes para todos los recursos
  common_tags = merge(
    var.tags,
    {
      Environment = var.environment
      Project     = var.project_name
      ManagedBy   = "terraform"
    }
  )

  # Lista de subredes publicas para el ALB
  subnet_ids = var.create_public_subnets ? var.public_subnet_ids : []
}

# Modulo de Application Load Balancer usando el modulo oficial de AWS
module "alb" {
  source  = "terraform-aws-modules/alb/aws"
  version = "~> 8.0"

  name = local.lb_name

  # Configuracion de listeners HTTP y HTTPS
  listeners = [
    {
      port               = var.http_port
      protocol           = "HTTP"
      target_group_index = 0
    },
    {
      port               = var.https_port
      protocol           = "HTTPS"
      certificate_arn    = var.ssl_certificate_arn
      target_group_index = 0
      ssl_policy         = var.ssl_policy
    }
  ]

  # Configuracion de target groups para los servicios de aplicacion
  target_groups = [
    {
      name              = "${var.environment}-app-tg"
      backend_protocol  = "HTTP"
      backend_port      = var.target_group_port
      target_type       = var.target_type
      health_check = {
        enabled             = var.health_check_enabled
        healthy_threshold   = var.health_check_healthy_threshold
        unhealthy_threshold = var.health_check_unhealthy_threshold
        timeout             = var.health_check_timeout
        interval            = var.health_check_interval
        path                = var.health_check_path
        matcher             = var.health_check_matcher
      }
      # Configuracion de deregistration delay para graceful shutdown
      deregistration_delay = var.deregistration_delay
      # Slow start para evitar saturacion de nuevas instancias
      slow_start = var.slow_start
      # Protocolo de health check
      health_check_protocol = "HTTP"
    }
  ]

  # Vpc y subredes donde se desplegara el ALB
  vpc_id = var.vpc_id
  subnets = var.create_public_subnets ? var.public_subnet_ids : var.private_subnet_ids

  # Configuracion de seguridad del ALB
  enable_deletion_protection = var.enable_deletion_protection
  enable_cross_zone_load_balancing = var.enable_cross_zone_load_balancing
  enable_http2 = var.enable_http2
  enable_waf_fail_open = var.enable_waf_fail_open

  # Tipo de balanceador: application (capa 7)
  load_balancer_type = "application"

  # IP fija para el ALB (no soportada en ALB, se usa en NLB)
  # Esta configuracion es para compatibilidad con la interfaz

  # Configuracion de access logs
  access_logs = var.enable_access_logs ? {
    bucket  = var.log_bucket_name
    prefix  = var.log_prefix
    enabled = true
  } : {
    enabled = false
  }

  # Security group para el ALB que permite trafico entrante
  security_groups = [module.alb_security_group.security_group_id]

  # Tags aplicados a todos los recursos
  tags = local.common_tags
}

# Security group para el ALB
module "alb_security_group" {
  source  = "terraform-aws-modules/security-group/aws"
  version = "~> 5.0"

  name        = "${local.lb_name}-sg"
  description = "Security group for Application Load Balancer"
  vpc_id      = var.vpc_id

  # Permitir trafico HTTP desde cualquier lugar
  ingress_with_cidr_blocks = [
    {
      from_port   = var.http_port
      to_port     = var.http_port
      protocol    = "tcp"
      cidr_blocks = "0.0.0.0/0"
      description = "HTTP access from anywhere"
    }
  ]

  # Permitir trafico HTTPS desde cualquier lugar
  ingress_with_cidr_blocks = [
    {
      from_port   = var.https_port
      to_port     = var.https_port
      protocol    = "tcp"
      cidr_blocks = "0.0.0.0/0"
      description = "HTTPS access from anywhere"
    }
  ]

  # Permitir todo el trafico saliente
  egress_with_cidr_blocks = [
    {
      from_port   = 0
      to_port     = 0
      protocol    = "-1"
      cidr_blocks = "0.0.0.0/0"
      description = "Allow all outbound traffic"
    }
  ]

  tags = local.common_tags
}

# Reglas de routing avanzadas basadas en path o host
# Esto permite direccionar trafico a diferentes servicios
resource "aws_lb_listener_rule" "app_routing" {
  count = length(var.routing_rules) > 0 ? length(var.routing_rules) : 0

  listener_arn = module.alb.http_tcp_listener_arns[0]
  priority     = var.listener_priority + count

  action {
    type             = "forward"
    target_group_arn = module.alb.target_group_arns[0]
  }

  condition {
    path_pattern {
      values = [var.routing_rules[count].path_pattern]
    }
  }

  tags = local.common_tags
}

# Regla de redirect para HTTP a HTTPS
resource "aws_lb_listener_rule" "http_to_https_redirect" {
  count = var.enable_http_to_https_redirect ? 1 : 0

  listener_arn = module.alb.http_tcp_listener_arns[0]
  priority     = var.listener_priority

  action {
    type = "redirect"

    redirect {
      port        = var.https_port
      protocol    = "HTTPS"
      status_code = "HTTP_301"
    }
  }

  condition {
    path_pattern {
      values = ["*"]
    }
  }

  tags = local.common_tags
}