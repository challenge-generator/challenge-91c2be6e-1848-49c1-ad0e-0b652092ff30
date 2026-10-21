# Configuración de variables para el ambiente de PRODUCCIÓN
# Objetivo: Alta disponibilidad, rendimiento óptimo y recuperación ante desastres
# Cumplimiento de SLA: 99.9% uptime, 5000 req/s, latencia < 200ms

# ============================================
# Configuración de Red y Entorno
# ============================================
environment             = "prod"
aws_region              = "us-east-1"
project_name            = "banking-platform"

# Tags obligatorios para identificación y costos
tags = {
  Environment     = "prod"
  Project         = "banking-platform"
  ManagedBy       = "terraform"
  CostCenter      = "it-production"
  ComplianceLevel = "pci-dss"
}

# ============================================
# Configuración del Cluster Tomcat (ECS/Fargate)
# ============================================
tomcat_cluster = {
  # Instancias grandes para producción - t3.large para alto rendimiento
  instance_type = "t3.large"
  
  # Réplicas para alta disponibilidad - mínimo 3 instancias
  # Distribuidas en múltiples AZs para tolerancia a fallos
  desired_capacity = 4
  min_capacity     = 3
  max_capacity     = 10
  
  # Configuración de escalado
  # Respuesta rápida para manejar picos de tráfico
  scale_up_cooldown    = 60
  scale_down_cooldown  = 300
  
  # Umbrales de escalado optimizados para 5000 req/s
  # Escalado proactivo basado en experiencia operativa
  scale_up_threshold   = 60
  scale_down_threshold = 25
  
  # Configuración de health check
  # Período de gracia más largo para estabilidad
  health_check_grace_period_seconds = 120
  
  # Timeout de tarea
  task_timeout_minutes = 30
}

# ============================================
# Configuración de Base de Datos RDS PostgreSQL
# ============================================
rds_postgresql = {
  # Instancia grande para producción - db.r6g.large (ARM) o db.r5.large (x86)
  instance_class = "db.r6g.large"
  
  # Almacenamiento generoso - 200GB para datos de producción
  allocated_storage_gb = 200
  
  # Storage type gp3 para IOPS garantizados
  storage_type = "gp3"
  
  # Multi-AZ obligatorio para producción
  multi_az = true
  
  # Backup retention largo - 30 días para cumplimiento PCI-DSS
  backup_retention_days = 30
  
  # Ventana de mantenimiento en horario de menor tráfico
  maintenance_window = "sun:01:00-sun:03:00"
  
  # Backup window en horario no crítico
  backup_window = "00:00-01:00"
  
  # Eliminación protegida - crítico para producción
  deletion_protection = true
  
  # Performance Insights activado para optimización continua
  enable_performance_insights = true
  
  # Logging completo para auditoría PCI-DSS
  enabled_cloudwatch_logs_exports = ["postgresql", "upgrade", "audit"]
  
  # Parámetros de conexión optimizados
  max_connections = 500
  
  # Cifrado en reposo obligatorio
  storage_encrypted = true
  
  # Habilitar aurora para mejor rendimiento
  # Nota: Si se usa Aurora, cambiar a aurora-postgresql
  engine = "postgres"
}

# ============================================
# Configuración del Load Balancer (ALB)
# ============================================
load_balancer = {
  # Protección contra eliminación obligatoria en producción
  enable_deletion_protection = true
  
  # Timeout de inactividad estándar para sesiones largas
  idle_timeout_seconds = 60
  
  # SSL obligatorio con certificado de producción
  enable_ssl = true
  
  # Access logs obligatoria para auditoría y análisis
  enable_access_logs = true
  
  # Cross-zone balancing obligatorio para HA
  enable_cross_zone_load_balancing = true
  
  # WAF habilitado para protección
  enable_waf = true
}

# ============================================
# Configuración de Monitoring y Alarmas
# ============================================
monitoring = {
  # Alarmas estrictas para cumplir SLA de 99.9%
  # Detección temprana de problemas
  
  # Umbral de CPU - 70% para respuesta proactiva
  cpu_alarm_threshold = 70
  
  # Umbral de memoria - 75%
  memory_alarm_threshold = 75
  
  # Umbral de latencia estricto - 200ms (SLA)
  latency_alarm_threshold_ms = 200
  
  # Umbral de errores muy bajo - 1%
  error_rate_threshold = 1
  
  # ALB 5xx errors threshold - muy estricto
  alb_5xx_threshold = 2
  
  # Target response time threshold
  target_response_time_threshold = 0.3
  
  # Período de evaluación corto para respuesta rápida
  evaluation_period_seconds = 60
  
  # Múltiples datapoints para evitar falsos positivos
  datapoints_to_alarm = 3
  
  # Slack channel para alertas de producción
  notification_topic = "prod-alerts-critical"
  
  # Dashboard detallado obligatorio
  create_detailed_dashboard = true
  
  # Métricas personalizadas habilitadas
  enable_custom_metrics = true
}

# ============================================
# Configuración de Alta Disponibilidad y Recuperación
# ============================================
ha_config = {
  # Alta disponibilidad completa en producción
  multi_az = true
  
  # RTO objetivo: 15 minutos (recuperación rápida)
  rto_hours = 0.25
  
  # RPO objetivo: 5 minutos (pérdida mínima de datos)
  rpo_hours = 0.083
  
  # Replicación activa entre regiones (disaster recovery)
  enable_replication = true
  
  # Región secundaria para DR
  dr_region = "us-west-2"
  
  # Failover automático habilitado
  enable_auto_failover = true
}

# ============================================
# Configuración de Seguridad Cumplimiento PCI-DSS
# ============================================
security_config = {
  # Habilitar VPC Flow Logs para auditoría
  enable_vpc_flow_logs = true
  
  # Habilitar GuardDuty
  enable_guardduty = true
  
  # Habilitar Security Hub
  enable_security_hub = true
  
  # Habilitar Config
  enable_config = true
  
  # Política de retención de logs
  logs_retention_days = 90
  
  # Habilitar encryption en tránsito
  enforce_ssl = true
}