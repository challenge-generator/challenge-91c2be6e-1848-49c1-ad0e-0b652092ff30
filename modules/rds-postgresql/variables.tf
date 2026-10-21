# Variables para el módulo de RDS PostgreSQL.
# Estas variables permiten personalizar la instancia de RDS, incluyendo tamaño,
# credenciales, configuración de replicación y backup.

variable "identifier" {
  description = "Identificador para la instancia RDS."
  type        = string
}

variable "engine" {
  description = "Motor de base de datos."
  type        = string
  default     = "postgres"
}

variable "engine_version" {
  description = "Versión del motor de base de datos."
  type        = string
}

variable "instance_class" {
  description = "Clase de instancia para RDS."
  type        = string
}

variable "allocated_storage" {
  description = "Almacenamiento asignado para RDS (GB)."
  type        = number
}

variable "max_allocated_storage" {
  description = "Almacenamiento máximo asignado para RDS (GB)."
  type        = number
}

variable "storage_encrypted" {
  description = "Habilitar cifrado para el almacenamiento de RDS."
  type        = bool
}

variable "database_name" {
  description = "Nombre de la base de datos."
  type        = string
  default     = "bankingdb"
}

variable "username" {
  description = "Nombre de usuario para la base de datos."
  type        = string
  default     = "admin"
}

variable "password" {
  description = "Contraseña para la base de datos."
  type        = string
  sensitive   = true
}

variable "port" {
  description = "Puerto para la base de datos."
  type        = number
  default     = 5432
}

variable "multi_az" {
  description = "Habilitar despliegue multi-AZ para RDS."
  type        = bool
}

variable "publicly_accessible" {
  description = "Indica si la instancia RDS es accesible públicamente."
  type        = bool
  default     = false
}

variable "subnet_ids" {
  description = "Lista de IDs de subredes para RDS."
  type        = list(string)
}

variable "vpc_security_group_ids" {
  description = "Lista de IDs de security groups para RDS."
  type        = list(string)
}

variable "backup_retention_period" {
  description = "Período de retención de backups para RDS (días)."
  type        = number
}

variable "skip_final_snapshot" {
  description = "Omitir la creación de un snapshot final al eliminar la instancia RDS."
  type        = bool
}

variable "deletion_protection" {
  description = "Habilitar protección contra eliminación para RDS."
  type        = bool
  default     = true
}

variable "performance_insights_enabled" {
  description = "Habilitar Performance Insights para RDS."
  type        = bool
  default     = true
}

variable "performance_insights_retention_period" {
  description = "Período de retención para Performance Insights (días)."
  type        = number
  default     = 7
}

variable "monitoring_interval" {
  description = "Intervalo de monitoreo para RDS (segundos)."
  type        = number
  default     = 60
}