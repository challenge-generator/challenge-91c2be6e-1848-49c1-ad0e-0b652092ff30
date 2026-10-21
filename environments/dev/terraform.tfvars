# Configuración de variables para el ambiente de DESARROLLO
# Objetivo: Entorno de desarrollo con recursos mínimos para reducir costos
# Las instancias pequeñas permiten iteraciones rápidas sin costos elevados

# ============================================
# Configuración de Red y Entorno
# ============================================
environment             = "dev"
aws_region              = "us-east-1"
project_name            = "banking-platform"

# Tags obligatorios para identificación y costos
tags = {
  Environment     = "dev"
  Project         = "banking-platform"
  ManagedBy       = "terraform"
  CostCenter      = "it-development"
  ComplianceLevel = "dev"
}

# ============================================
# Configuración del Cluster Tomcat (ECS/Fargate)
# ============================================
tomcat_cluster = {
  # Instancia pequeña para desarrollo - t3.small es suficiente para pruebas
  instance_type = "t3.small"
  
  # Réplicas mínimas - solo 1 instancia para降低成本 en dev
  desired_capacity = 1
  min_capacity     = 1
  max_capacity     = 2
  
  # Configuración de escalado
  # En dev no necesitamos escalado agresivo
  scale_up_cooldown    = 300
  scale_down_cooldown  = 300
  
  # Umbrales de escalado (porcentage de CPU)
  # Umbrales más permisivos para ambiente de desarrollo
  scale_up_threshold   = 70
  scale_down_threshold = 30
  
  # Configuración de health check
  health_check_grace_period_seconds = 60
  
  # Timeout de tarea
  task_timeout_minutes = 10
}

# ============================================
# Configuración de Base de Datos RDS PostgreSQL
# ============================================
rds_postgresql = {
  # Instancia pequeña para desarrollo - db.t3.micro tiene recursos suficientes
  instance_class = "db.t3.micro"
  
  # Almacenamiento mínimo - 20GB es suficiente para desarrollo
  allocated_storage_gb = 20
  
  # Storage type gp3 para mejor rendimiento
  storage_type = "gp3"
  
  # Multi-AZ desactivado para development - reduce costos
  multi_az = false
  
  # Backup retention corto para development
  backup_retention_days = 1
  
  # Ventana de mantenimiento en horario no crítico
  maintenance_window = "sun:04:00-sun:05:00"
  
  # Backup window en horario no crítico
  backup_window = "03:00-04:00"
  
  # Eliminación automática desactivada para protección en dev
  deletion_protection = false
  
  # Performance Insights desactivado para reducir costos
  enable_performance_insights = false
  
  # Logging de errores únicamente
  enabled_cloudwatch_logs_exports = ["postgresql", "upgrade"]
  
  # Parámetros de conexión
  max_connections = 100
  
  # Cifrado en reposo
  storage_encrypted = true
}

# ============================================
# Configuración del Load Balancer (ALB)
# ============================================
load_balancer = {
  # Protección contra eliminación activada por seguridad
  enable_deletion_protection = false
  
  # Timeout de inactividad reducido para desarrollo
  idle_timeout_seconds = 30
  
  # SSL no requerido en desarrollo
  enable_ssl = false
  
  # Access logs deshabilitados para reducir costos
  enable_access_logs = false
  
  # Cross-zone balancing activado
  enable_cross_zone_load_balancing = true
}

# ============================================
# Configuración de Monitoring y Alarmas
# ============================================
monitoring = {
  # Alarmas con umbrales más permisivos para desarrollo
  # No queremos alertas excesivas en entorno de desarrollo
  
  # Umbral de CPU - 80% para desarrollo
  cpu_alarm_threshold = 80
  
  # Umbral de memoria - 85%
  memory_alarm_threshold = 85
  
  # Umbral de latencia - 500ms (más permisivo que prod)
  latency_alarm_threshold_ms = 500
  
  # Umbral de errores - 5%
  error_rate_threshold = 5
  
  # ALB 5xx errors threshold
  alb_5xx_threshold = 10
  
  # Target response time threshold
  target_response_time_threshold = 1
  
  # Período de evaluación más corto para desarrollo
  evaluation_period_seconds = 300
  
  # Período de datos para alarma
  datapoints_to_alarm = 2
  
  # Slack channel para notificaciones (puede ser un canal de dev)
  notification_topic = "dev-alerts"
  
  # Dashboard detallado desactivado para reducir costos
  create_detailed_dashboard = false
}

# ============================================
# Configuración de Alta Disponibilidad
# ============================================
ha_config = {
  # Alta disponibilidad desactivada en desarrollo
  # Solo 1 AZ para reducir costos
  enable_multi_az = false
  
  # RTO objetivo en horas (desarrollo más permisivo)
  rto_hours = 4
  
  # RPO objetivo en horas
  rpo_hours = 1
  
  # Replicación de datos desactivada
  enable_replication = false
}