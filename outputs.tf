# ============================================================================
# OUTPUTS DEL PROYECTO - Valores generados por la infraestructura
# ============================================================================

# Outputs del Cluster ECS
output "ecs_cluster_id" {
  description = "ID del cluster ECS"
  value       = module.tomcat_cluster.cluster_id
}

output "ecs_cluster_name" {
  description = "Nombre del cluster ECS"
  value       = module.tomcat_cluster.cluster_name
}

output "ecs_cluster_arn" {
  description = "ARN del cluster ECS"
  value       = module.tomcat_cluster.cluster_arn
}

output "ecs_service_name" {
  description = "Nombre del servicio ECS"
  value       = module.tomcat_cluster.service_name
}

output "ecs_task_definition_arn" {
  description = "ARN de la tarea ECS"
  value       = module.tomcat_cluster.task_definition_arn
}

output "ecs_container_name" {
  description = "Nombre del contenedor Tomcat"
  value       = module.tomcat_cluster.container_name
}

# Outputs de RDS
output "rds_instance_id" {
  description = "ID de la instancia RDS"
  value       = module.rds_postgresql.instance_id
}

output "rds_endpoint" {
  description = "Endpoint de conexión a la base de datos"
  value       = module.rds_postgresql.endpoint
  sensitive   = true
}

output "rds_arn" {
  description = "ARN de la instancia RDS"
  value       = module.rds_postgresql.instance_arn
}

output "rds_port" {
  description = "Puerto de la base de datos"
  value       = module.rds_postgresql.port
}

output "rds_db_name" {
  description = "Nombre de la base de datos"
  value       = module.rds_postgresql.db_name
}

output "rds_multi_az" {
  description = "Indicador de configuración multi-AZ"
  value       = module.rds_postgresql.multi_az
}

# Outputs del Load Balancer
output "alb_arn" {
  description = "ARN del Application Load Balancer"
  value       = module.load_balancer.arn
}

output "alb_name" {
  description = "Nombre del ALB"
  value       = module.load_balancer.name
}

output "alb_dns_name" {
  description = "DNS name del ALB para acceso externo"
  value       = module.load_balancer.dns_name
}

output "alb_zone_id" {
  description = "Zone ID del ALB para Route 53"
  value       = module.load_balancer.zone_id
}

output "alb_target_group_arn" {
  description = "ARN del target group de Tomcat"
  value       = module.load_balancer.target_group_arns[0]
}

output "alb_listener_arns" {
  description = "ARNs de los listeners del ALB"
  value       = module.load_balancer.listener_arns
}

# Outputs de Monitoreo
output "cloudwatch_log_group_name" {
  description = "Nombre del grupo de logs de CloudWatch"
  value       = module.monitoring.log_group_name
}

output "cloudwatch_log_group_arn" {
  description = "ARN del grupo de logs de CloudWatch"
  value       = module.monitoring.log_group_arn
}

output "sns_topic_arn" {
  description = "ARN del topic SNS para notificaciones de alarmas"
  value       = module.monitoring.sns_topic_arn
}

# Outputs de seguridad
output "ecs_security_group_id" {
  description = "ID del security group del cluster ECS"
  value       = aws_security_group.ecs.id
}

output "rds_security_group_id" {
  description = "ID del security group de RDS"
  value       = aws_security_group.rds.id
}

output "alb_security_group_id" {
  description = "ID del security group del ALB"
  value       = aws_security_group.alb.id
}

# Outputs de red
output "vpc_id" {
  description = "ID de la VPC utilizada"
  value       = data.aws_vpc.main.id
}

output "vpc_cidr_block" {
  description = "CIDR block de la VPC"
  value       = data.aws_vpc.main.cidr_block
}

output "private_subnet_ids" {
  description = "IDs de las subnets privadas"
  value       = data.aws_subnets.private.ids
}

output "public_subnet_ids" {
  description = "IDs de las subnets públicas"
  value       = data.aws_subnets.public.ids
}