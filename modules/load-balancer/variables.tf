# Variables para el módulo de Application Load Balancer (ALB).
# Estas variables permiten personalizar las subredes, certificados SSL y targets del balanceador.

variable "name" {
  description = "Nombre del Application Load Balancer."
  type        = string
}

variable "internal" {
  description = "Indica si el ALB es interno."
  type        = bool
}

variable "load_balancer_type" {
  description = "Tipo de load balancer."
  type        = string
  default     = "application"
}

variable "subnets" {
  description = "Lista de IDs de subredes para el ALB."
  type        = list(string)
}

variable "security_group_ids" {
  description = "Lista de IDs de security groups para el ALB.
  type        = list(string)
}

variable "idle_timeout" {
  description = "Tiempo de espera inactivo para el ALB (segundos)."
  type        = number
}

variable "enable_deletion_protection" {
  description = "Habilitar protección contra eliminación para el ALB."
  type        = bool
  default     = true
}

variable "http_tcp_listeners" {
  description = "Lista de listeners HTTP/TCP para el ALB."
  type = list(object({
    port               = number
    protocol           = string
    target_group_index = number
  }))
}

variable "https_listeners" {
  description = "Lista de listeners HTTPS para el ALB."
  type = list(object({
    port               = number
    protocol           = string
    certificate_arn    = string
    target_group_index = number
  }))
}

variable "target_groups" {
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
}

variable "tags" {
  description = "Tags para el ALB."
  type        = map(string)
  default     = {}
}