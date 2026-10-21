# Variables para el módulo de cluster de Tomcat.
# Estas variables permiten personalizar el tamaño de las instancias, el número de réplicas,
# la imagen Docker utilizada y las políticas IAM aplicadas al servicio.

variable "cluster_name" {
  description = "Nombre del cluster ECS para Tomcat."
  type        = string
}

variable "desired_count" {
  description = "Número deseado de tareas en el servicio ECS."
  type        = number
  default     = 2
}

variable "cpu" {
  description = "CPU asignada a cada tarea de ECS (unidades de CPU)."
  type        = number
  default     = 1024
}

variable "memory" {
  description = "Memoria asignada a cada tarea de ECS (MB)."
  type        = number
  default     = 2048
}

variable "docker_image" {
  description = "Imagen Docker para el contenedor de Tomcat."
  type        = string
  default     = "tomcat:9.0-jdk11-openjdk-slim"
}

variable "container_port" {
  description = "Puerto expuesto por el contenedor de Tomcat."
  type        = number
  default     = 8080
}

variable "subnets" {
  description = "Lista de IDs de subredes donde se desplegará el servicio ECS."
  type        = list(string)
}

variable "security_group_ids" {
  description = "Lista de IDs de security groups para el servicio ECS."
  type        = list(string)
}

variable "target_group_arn" {
  description = "ARN del target group para el ALB."
  type        = string
}

variable "enable_execute_command" {
  description = "Habilitar execute command para el servicio ECS."
  type        = bool
  default     = true
}

variable "deployment_minimum_healthy_percent" {
  description = "Porcentaje mínimo de tareas saludables durante el despliegue."
  type        = number
  default     = 50
}

variable "deployment_maximum_percent" {
  description = "Porcentaje máximo de tareas durante el despliegue."
  type        = number
  default     = 200
}

variable "autoscaling_min_capacity" {
  description = "Capacidad mínima para el escalado automático."
  type        = number
  default     = 2
}

variable "autoscaling_max_capacity" {
  description = "Capacidad máxima para el escalado automático."
  type        = number
  default     = 10
}

variable "autoscaling_cpu_target" {
  description = "Umbral de utilización de CPU para escalado automático (porcentaje)."
  type        = number
  default     = 70
}

variable "autoscaling_memory_target" {
  description = "Umbral de utilización de memoria para escalado automático (porcentaje)."
  type        = number
  default     = 80
}

variable "iam_role_arn" {
  description = "ARN del rol IAM para el servicio ECS."
  type        = string
}