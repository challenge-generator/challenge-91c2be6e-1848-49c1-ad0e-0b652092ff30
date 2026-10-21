# Variables para el módulo de monitoreo.
# Estas variables permiten configurar umbrales para alarmas de CloudWatch,
# incluyendo latencia, errores y saturación de recursos.

variable "cluster_name" {
  description = "Nombre del cluster ECS monitoreado."
  type        = string
}

variable "service_name" {
  description = "Nombre del servicio ECS monitoreado."
  type        = string
}

variable "alb_arn_suffix" {
  description = "ARN suffix del Application Load Balancer."
  type        = string
}

variable "latency_threshold" {
  description = "Umbral de latencia para alarmas (milisegundos)."
  type        = number
}

variable "error_threshold" {
  description = "Umbral de errores para alarmas (porcentaje)."
  type        = number
}

variable "cpu_threshold" {
  description = "Umbral de utilización de CPU para alarmas (porcentaje)."
  type        = number
}

variable "memory_threshold" {
  description = "Umbral de utilización de memoria para alarmas (porcentaje)."
  type        = number
}

variable "sns_topic_arn" {
  description = "ARN del topic SNS para notificaciones de alarmas."
  type        = string
}

variable "evaluation_periods" {
  description = "Número de períodos de evaluación para las alarmas."
  type        = number
  default     = 2
}

variable "period" {
  description = "Duración de cada período de evaluación (segundos)."
  type        = number
  default     = 60
}

variable "statistic" {
  description = "Estadística utilizada para las métricas (Average, Sum, etc.)."
  type        = string
  default     = "Average"
}

variable "namespace" {
  description = "Namespace de CloudWatch para las métricas."
  type        = string
  default     = "AWS/ECS"
}

variable "alarm_actions" {
  description = "Lista de acciones a ejecutar cuando se dispara una alarma."
  type        = list(string)
  default     = []
}

variable "ok_actions" {
  description = "Lista de acciones a ejecutar cuando una alarma vuelve a OK."
  type        = list(string)
  default     = []
}

variable "insufficient_data_actions" {
  description = "Lista de acciones a ejecutar cuando una alarma tiene datos insuficientes."
  type        = list(string)
  default     = []
}