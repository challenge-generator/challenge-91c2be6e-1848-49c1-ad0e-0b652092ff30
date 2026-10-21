# Variables globales para personalizar la infraestructura por ambiente.
# Estas variables son usadas por los módulos y definen parámetros como tamaños de instancia,
# número de réplicas, configuraciones de red y seguridad.

variable "aws_region" {
  description = "Región de AWS donde se desplegará la infraestructura."
  type        = string
  default     = "us-east-1"
}

variable "environment" {
  description = "Ambiente de despliegue (dev, qa, prod)."
  type        = string
  validation {
    condition     = contains(["dev", "qa", "prod"], var.environment)
    error_message = "El ambiente debe ser uno de: dev, qa, prod."
  }
}

variable "vpc_cidr" {
  description = "Bloque CIDR para la VPC."
  type        = string
  default     = "10.0.0.0/16"
}

variable "public_subnets" {
  description = "Lista de CIDRs para subredes públicas."
  type        = list(string)
  default     = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]
}

variable "private_subnets" {
  description = "Lista de CIDRs para subredes privadas."
  type        = list(string)
  default     = ["10.0.101.0/24", "10.0.102.0/24", "10.0.103.0/24"]
}

variable "database_subnets" {
  description = "Lista de CIDRs para subredes de base de datos."
  type        = list(string)
  default     = ["10.0.201.0/24", "10.0.202.0/24", "10.0.203.0/24"]
}

variable "tomcat_cluster_name" {
  description = "Nombre del cluster de Tomcat."
  type        = string
  default     = "tomcat-cluster"
}

variable "rds_instance_class" {
  description = "Clase de instancia para RDS PostgreSQL."
  type        = string
  default     = "db.t3.medium"
}

variable "rds_allocated_storage" {
  description = "Almacenamiento asignado para RDS PostgreSQL (GB)."
  type        = number
  default     = 20
}

variable "rds_max_allocated_storage" {
  description = "Almacenamiento máximo asignado para RDS PostgreSQL (GB)."
  type        = number
  default     = 100
}

variable "rds_engine_version" {
  description = "Versión del motor de PostgreSQL."
  type        = string
  default     = "13.4"
}

variable "rds_multi_az" {
  description = "Habilitar despliegue multi-AZ para RDS."
  type        = bool
  default     = true
}

variable "rds_backup_retention_period" {
  description = "Período de retención de backups para RDS (días)."
  type        = number
  default     = 7
}

variable "rds_skip_final_snapshot" {
  description = "Omitir la creación de un snapshot final al eliminar la instancia RDS."
  type        = bool
  default     = false
}

variable "rds_storage_encrypted" {
  description = "Habilitar cifrado para el almacenamiento de RDS."
  type        = bool
  default     = true
}

variable "alb_internal" {
  description = "Indica si el Application Load Balancer es interno."
  type        = bool
  default     = false
}

variable "alb_idle_timeout" {
  description = "Tiempo de espera inactivo para el ALB (segundos)."
  type        = number
  default     = 60
}

variable "alb_http_tcp_listeners" {
  description = "Lista de listeners HTTP/TCP para el ALB."
  type = list(object({
    port               = number
    protocol           = string
    target_group_index = number
  }))
  default = [
    {
      port               = 80
      protocol           = "HTTP"
      target_group_index = 0
    }
  ]
}

variable "alb_https_listeners" {
  description = "Lista de listeners HTTPS para el ALB."
  type = list(object({
    port               = number
    protocol           = string
    certificate_arn    = string
    target_group_index = number
  }))
  default = []
}

variable "alb_target_groups" {
  description = "Lista de target groups para el ALB."
  type = list(object({
    name             = string
    backend_protocol = string
    backend_port     = number
    target_type      = string
    health_check = object({
      path                = string
      port                = string
      healthy_threshold   = number
      unhealthy_threshold = number
      timeout             = number
      interval            = number
      matcher             = string
    })
  }))
  default = [
    {
      name             = "tomcat-tg"
      backend_protocol = "HTTP"
      backend_port     = 8080
      target_type      = "ip"
      health_check = {
        path                = "/health"
        port                = "traffic-port"
        healthy_threshold   = 3
        unhealthy_threshold = 3
        timeout             = 5
        interval            = 30
        matcher             = "200"
      }
    }
  ]
}

variable "monitoring_latency_threshold" {
  description = "Umbral de latencia para alarmas de CloudWatch (milisegundos)."
  type        = number
  default     = 200
}

variable "monitoring_error_threshold" {
  description = "Umbral de errores para alarmas de CloudWatch (porcentaje)."
  type        = number
  default     = 1
}

variable "monitoring_cpu_threshold" {
  description = "Umbral de utilización de CPU para escalado automático (porcentaje)."
  type        = number
  default     = 70
}

variable "monitoring_memory_threshold" {
  description = "Umbral de utilización de memoria para escalado automático (porcentaje)."
  type        = number
  default     = 80
}