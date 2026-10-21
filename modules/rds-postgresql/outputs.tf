output "db_instance_endpoint" {
  description = "The connection endpoint for the RDS database instance"
  value       = module.rds.db_instance_endpoint
}

output "db_instance_address" {
  description = "The address of the RDS database instance"
  value       = module.rds.db_instance_address
}

output "db_instance_arn" {
  description = "The ARN of the RDS database instance"
  value       = module.rds.db_instance_arn
}

output "db_instance_name" {
  description = "The name of the RDS database instance"
  value       = module.rds.db_instance_name
}

output "db_instance_port" {
  description = "The port of the RDS database instance"
  value       = module.rds.db_instance_port
}

output "db_instance_id" {
  description = "The ID of the RDS database instance"
  value       = module.rds.db_instance_id
}

output "db_subnet_group_name" {
  description = "The name of the DB subnet group"
  value       = module.rds.db_subnet_group_name
}

output "security_group_id" {
  description = "The ID of the security group attached to RDS"
  value       = module.rds.security_group_id
}

output "db_enhanced_monitoring_iam_role_arn" {
  description = "The ARN of the IAM role for Enhanced Monitoring"
  value       = module.rds.enhanced_monitoring_iam_role_arn
}

output "db_parameter_group_id" {
  description = "The ID of the DB parameter group"
  value       = module.rds.db_parameter_group_id
}

output "db_option_group_id" {
  description = "The ID of the DB option group"
  value       = module.rds.db_option_group_id
}

output "db_master_user_secret_arn" {
  description = "The ARN of the secret containing the master user credentials"
  value       = module.rds.db_master_user_secret_arn
  sensitive   = true
}