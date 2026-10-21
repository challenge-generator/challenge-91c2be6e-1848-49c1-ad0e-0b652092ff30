# Configuración de variables para el ambiente de QA
# Objetivo: Validación de funcionalidad y rendimiento antes de producción
# Instancias medianas con configuración que simula producción a menor escala

# ============================================
# Configuración de Red y Entorno
# ============================================
environment             = "qa"
aws_region              = "us-east-1"
project_name            = "banking-platform"

# Tags obligatorios para identificación y costos
tags = {
  Environment     = "qa"
  Project         = "banking-platform"
  ManagedBy       = "terraform"
  CostCenter      = "it-quality-assurance"
  ComplianceLevel = "internal"
}

# ============================================
# Configuración del Cluster Tomcat (ECS/Fargate)
# ============================================
tomcat_cluster = {
  # Instancia mediana para QA - t3.medium para pruebas de carga
  instance_type = "t3.medium"
  
  # Réplicas intermedias - 2 instancias para pruebas de concurrencia
  desired_capacity = 2
  min_capacity     = 2
  max_capacity     = 4
  
  # Configuración de escalado
  # Cooldowns más cortos para responder más rápido en QA
  scale_up_cooldown    = 180
  scale_down_cooldown  = 180
  
  # Umbrales de escalado (porcentage de CPU)
  # Más sensibles que producción para detectar problemas temprano
  scale_up_threshold   = 65
  scale_down_threshold = 35
  
  # Configuración de health check
  health_check_grace_period_seconds = 90
  
  # Timeout de tarea
  task_timeout_minutes = 15
}

# ============================================
# Configuración de Base de Datos RDS PostgreSQL
# ============================================
rds_postgresql = {
  # Instancia mediana para QA - db.t3.small para pruebas de carga
  instance_class = "db.t3.small"
  
  # Almacenamiento moderado - 50GB para datos de pruebas
  allocated_storage_gb = 50
  
  # Storage type gp3 para mejor rendimiento
  storage_type = "gp3"
  
  # Multi-AZ activado para simular entorno de producción
  multi_az = true
  
  # Backup retention moderado - 7 días para QA
  backup_retention_days = 7
  
  # Ventana de mantenimiento en horario no crítico
  maintenance_window = "sun:02:00-sun:03:00"
  
  # Backup window en horario no crítico
  backup_window = "01:00-02:00"
  
  # Eliminación protegida
  deletion_protection = true
  
  # Performance Insights activado para análisis
  enable_performance_insights = true
  
  # Logging completo para debugging
  enabled_cloudwatch_logs_exports = ["postgresql", "upgrade", "audit"]
  
  # Parámetros de conexión
  max_connections = 200
  
  # Cifrado en reposo
  storage_encrypted = true
}

# ============================================
# Configuración del Load Balancer (ALB)
# ============================================
load_balancer = {
  # Protección contra eliminación activada
  enable_deletion_protection = true
  
  # Timeout de inactividad estándar
  idle_timeout_seconds = 60
  
  # SSL activado para pruebas de certificados
  enable_ssl = true
  
  # Access logs habilitados para análisis
  enable_access_logs = true
  
  # Cross-zone balancing activado
  enable_cross_zone_load_balancing = true
}

# ============================================
# Configuración de Monitoring y Alarmas
# ============================================
monitoring = {
  # Alarmas con umbrales intermedios
  # Simulan producción pero con margen para pruebas
  
  # Umbral de CPU - 75%
  cpu_alarm_threshold = 75
  
  # Umbral de memoria - 80%
  memory_alarm_threshold = 80
  
  # Umbral de latencia - 300ms
  latency_alarm_threshold_ms = 300
  
  # Umbral de errores - 3%
  error_rate_threshold = 3
  
  # ALB 5xx errors threshold
  alb_5xx_threshold = 5
  
  # Target response time threshold
  target_response_time_threshold = 0.5
  
  # Período de evaluación estándar
  evaluation_period_seconds = 180
  
  # Período de datos para alarma
  datapoints_to_alarm = 2
  
  # Slack channel para notificaciones de QA
  notification_topic = "qa-alerts"
  
  # Dashboard detallado activado
  create_detailed_dashboard = true
}

# ============================================
# Configuración de Alta Disponibilidad
# ============================================
ha_config = {
  # Alta disponibilidad activada en QA
  multi_az = true
  
  # RTO objetivo en horas
  rto_hours = 2
  
  # RPO objetivo en horas
  rpo_hours = 1
  
  # Replicación activada
  enable_replication = true
}