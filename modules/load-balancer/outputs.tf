output "alb_arn" {
  description = "The ARN of the Application Load Balancer"
  value       = module.alb.arn
}

output "alb_arn_suffix" {
  description = "The ARN suffix of the Application Load Balancer"
  value       = module.alb.arn_suffix
}

output "alb_dns_name" {
  description = "The DNS name of the Application Load Balancer"
  value       = module.alb.dns_name
}

output "alb_zone_id" {
  description = "The zone ID of the Application Load Balancer"
  value       = module.alb.zone_id
}

output "alb_id" {
  description = "The ID of the Application Load Balancer"
  value       = module.alb.id
}

output "alb_name" {
  description = "The name of the Application Load Balancer"
  value       = module.alb.name
}

output "alb_security_group_id" {
  description = "The ID of the security group attached to the ALB"
  value       = module.alb_security_group.security_group_id
}

output "alb_security_group_arn" {
  description = "The ARN of the security group attached to the ALB"
  value       = module.alb_security_group.security_group_arn
}

output "target_group_arn" {
  description = "The ARN of the target group"
  value       = module.alb.target_group_arns[0]
}

output "target_group_name" {
  description = "The name of the target group"
  value       = module.alb.target_group_names[0]
}

output "target_group_id" {
  description = "The ID of the target group"
  value       = module.alb.target_group_ids[0]
}

output "http_listener_arn" {
  description = "The ARN of the HTTP listener"
  value       = module.alb.http_tcp_listener_arns[0]
}

output "https_listener_arn" {
  description = "The ARN of the HTTPS listener"
  value       = module.alb.https_listener_arns[0]
}

output "http_listener_id" {
  description = "The ID of the HTTP listener"
  value       = module.alb.http_tcp_listener_ids[0]
}

output "https_listener_id" {
  description = "The ID of the HTTPS listener"
  value       = module.alb.https_listener_ids[0]
}

output "access_logs_bucket" {
  description = "The name of the S3 bucket for access logs"
  value       = var.enable_access_logs ? var.log_bucket_name : null
}

output "security_group_name" {
  description = "The name of the ALB security group"
  value       = module.alb_security_group.security_group_name
}