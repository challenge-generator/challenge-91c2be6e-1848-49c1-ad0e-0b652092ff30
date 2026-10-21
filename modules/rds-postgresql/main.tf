terraform {
  required_version = ">= 1.7"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

locals {
  name_prefix   = var.prefix != "" ? "${var.prefix}-${var.db_instance_name}" : var.db_instance_name
  common_tags = merge(
    var.common_tags,
    {
      Project     = var.project_name
      Environment = var.environment
      ManagedBy   = "terraform"
      Component   = "database"
      Engine      = "postgresql"
    }
  )

  final_snapshot_identifier = var.skip_final_snapshot ? null : "${local.name_prefix}-final-snapshot-${formatdate("YYYYMMDD", timestamp())}"
}

resource "aws_db_subnet_group" "this" {
  name       = local.name_prefix
  subnet_ids = var.vpc_subnet_ids

  tags = local.common_tags
}

resource "aws_security_group" "rds" {
  name        = "${local.name_prefix}-sg"
  description = "Security group for RDS PostgreSQL instance"
  vpc_id      = var.vpc_id

  ingress {
    from_port       = var.db_port
    to_port         = var.db_port
    protocol        = "tcp"
    cidr_blocks     = var.allowed_cidr_blocks
    description     = "PostgreSQL access from allowed CIDRs"
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
    description = "Allow all outbound"
  }

  tags = local.common_tags
}

resource "aws_db_instance" "this" {
  identifier = local.name_prefix

  engine                   = "postgres"
  engine_version           = var.engine_version
  instance_class           = var.instance_class
  allocated_storage        = var.allocated_storage
  max_allocated_storage    = var.max_allocated_storage
  storage_type             = var.storage_type
  storage_encrypted        = var.storage_encrypted

  db_name  = var.db_name
  username = var.master_username
  password = var.master_password
  port     = var.db_port

  db_subnet_group_name   = aws_db_subnet_group.this.name
  vpc_security_group_ids = concat([aws_security_group.rds.id], var.extra_security_group_ids)

  multi_az = var.enable_multi_az ? var.db_hosted_zone_id != "" ? var.db_hosted_zone_id : "${var.availability_zones[0]}" : ""

  backup_retention_period = var.backup_retention_days
  backup_window           = var.backup_window
  maintenance_window      = var.maintenance_window

  skip_final_snapshot       = var.skip_final_snapshot
  final_snapshot_identifier = local.final_snapshot_identifier

  copy_tags_to_snapshot   = var.copy_tags_to_snapshot
  delete_automated_backups = var.delete_automated_backups
  deletion_protection      = var.deletion_protection

  enabled_cloudwatch_logs_exports = var.enabled_cloudwatch_logs_exports

  performance_insights_enabled = var.enable_performance_insights
  performance_insights_kms_key_id = var.performance_insights_kms_key_arn

  monitoring_interval = var.enable_enhanced_monitoring ? var.monitoring_interval : 0
  monitoring_role_arn = var.enable_enhanced_monitoring ? aws_iam_role.rds_monitoring_role[0].arn : ""

  allow_major_version_upgrade = var.allow_major_version_upgrade
  auto_minor_version_upgrade  = var.auto_minor_version_upgrade
  apply_immediately           = var.apply_immediately

  lifecycle {
    create_before_destroy = true
    ignore_changes        = [password]
  }

  tags = local.common_tags
}

resource "aws_iam_role" "rds_monitoring_role" {
  count = var.enable_enhanced_monitoring ? 1 : 0
  name  = "${local.name_prefix}-monitoring-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Principal = {
          Service = ["monitoring.rds.amazonaws.com"]
        }
      }
    ]
  })

  tags = local.common_tags
}

resource "aws_iam_role_policy_attachment" "rds_monitoring_policy" {
  count = var.enable_enhanced_monitoring ? 1 : 0
  role       = aws_iam_role.rds_monitoring_role[0].name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonRDSEnhancedMonitoringRole"
}

resource "aws_db_instance" "read_replica" {
  count = var.create_read_replica ? var.read_replica_count : 0

  identifier = "${local.name_prefix}-replica-${count.index}"

  engine                   = "postgres"
  engine_version           = var.engine_version
  instance_class           = var.read_replica_instance_class
  allocated_storage        = var.allocated_storage
  storage_type             = var.storage_type
  storage_encrypted        = var.storage_encrypted

  db_name  = var.db_name
  username = var.master_username
  password = var.master_password
  port     = var.db_port

  db_subnet_group_name   = aws_db_subnet_group.this.name
  vpc_security_group_ids = concat([aws_security_group.rds.id], var.extra_security_group_ids)

  source_db_instance_identifier = aws_db_instance.this.identifier
  replicate_source_db           = aws_db_instance.this.identifier

  backup_retention_period = var.read_replica_backup_retention
  backup_window           = var.backup_window
  maintenance_window      = var.maintenance_window

  skip_final_snapshot       = true
  copy_tags_to_snapshot     = var.copy_tags_to_snapshot
  deletion_protection       = var.read_replica_deletion_protection

  enabled_cloudwatch_logs_exports = var.enabled_cloudwatch_logs_exports

  monitoring_interval = var.enable_enhanced_monitoring ? var.monitoring_interval : 0
  monitoring_role_arn = var.enable_enhanced_monitoring ? aws_iam_role.rds_monitoring_role[0].arn : ""

  auto_minor_version_upgrade = var.auto_minor_version_upgrade
  apply_immediately          = var.apply_immediately

  lifecycle {
    create_before_destroy = true
    ignore_changes        = [password]
  }

  tags = merge(local.common_tags, { Replica = "true" })
}

resource "aws_rds_cluster_parameter_group" "this" {
  count = length(var.custom_parameters) > 0 ? 1 : 0

  name   = "${local.name_prefix}-params"
  family = "postgres${var.custom_parameter_family}"

  dynamic "parameter" {
    for_each = var.custom_parameters
    content {
      name         = parameter.value.name
      value        = parameter.value.value
      apply_method = parameter.value.apply_method
    }
  }

  tags = local.common_tags
}

resource "aws_kms_key" "rds" {
  count = var.storage_encrypted && var.create_kms_key ? 1 : 0

  description             = "KMS key for RDS ${local.name_prefix}"
  deletion_window_in_days = 10
  enable_key_rotation     = var.enable_key_rotation

  policy = jsonencode({
    Version = "2012-10-17"
    Id      = "key-policy"
    Statement = [
      {
        Sid    = "Enable IAM User Permissions"
        Effect = "Allow"
        Principal = {
          AWS = "arn:aws:iam::${var.account_id}:root"
        }
        Action   = "kms:*"
        Resource = "*"
      },
      {
        Sid    = "Allow use of the key"
        Effect = "Allow"
        Principal = {
          Service = ["rds.amazonaws.com"]
        }
        Action = [
          "kms:Encrypt",
          "kms:Decrypt",
          "kms:ReEncrypt*",
          "kms:GenerateDataKey*",
          "kms:DescribeKey",
          "kms:CreateGrant"
        ]
        Resource = "*"
        Condition = {
          StringEquals = {
            "kms:CallerAccount" = [var.account_id]
          }
        }
      }
    ]
  })

  tags = local.common_tags
}

resource "aws_kms_alias" "rds" {
  count = var.storage_encrypted && var.create_kms_key ? 1 : 0

  name          = "alias/${local.name_prefix}-rds"
  target_key_id = aws_kms_key.rds[0].key_id
}

resource "aws_cloudwatch_metric_alarm" "cpu_utilization" {
  alarm_name          = "${local.name_prefix}-cpu-utilization"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = var.alarm_evaluation_periods
  metric_name         = "CPUUtilization"
  namespace           = "AWS/RDS"
  period              = var.alarm_period
  statistic           = "Average"
  threshold           = var.alarm_cpu_threshold
  alarm_description   = "This metric monitors RDS CPU utilization"
  alarm_actions       = var.alarm_actions
  ok_actions          = var.alarm_actions

  dimensions = {
    DBInstanceIdentifier = aws_db_instance.this.identifier
  }

  tags = local.common_tags
}

resource "aws_cloudwatch_metric_alarm" "storage_utilization" {
  alarm_name          = "${local.name_prefix}-storage-utilization"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = var.alarm_evaluation_periods
  metric_name         = "StorageUtilization"
  namespace           = "AWS/RDS"
  period              = var.alarm_period
  statistic           = "Average"
  threshold           = var.alarm_storage_threshold
  alarm_description   = "This metric monitors RDS storage utilization"
  alarm_actions       = var.alarm_actions
  ok_actions          = var.alarm_actions

  dimensions = {
    DBInstanceIdentifier = aws_db_instance.this.identifier
  }

  tags = local.common_tags
}

resource "aws_cloudwatch_metric_alarm" "connections" {
  alarm_name          = "${local_name_prefix}-connections"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = var.alarm_evaluation_periods
  metric_name         = "DatabaseConnections"
  namespace           = "AWS/RDS"
  period              = var.alarm_period
  statistic           = "Average"
  threshold           = var.alarm_connections_threshold
  alarm_description   = "This metric monitors RDS database connections"
  alarm_actions       = var.alarm_actions
  ok_actions          = var.alarm_actions

  dimensions = {
    DBInstanceIdentifier = aws_db_instance.this.identifier
  }

  tags = local.common_tags
}

resource "aws_cloudwatch_metric_alarm" "read_io" {
  count = var.create_read_replica ? var.read_replica_count : 0

  alarm_name          = "${local.name_prefix}-replica-${count.index}-read-io"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = var.alarm_evaluation_periods
  metric_name         = "ReadIOPS"
  namespace           = "AWS/RDS"
  period              = var.alarm_period
  statistic           = "Average"
  threshold           = var.alarm_read_iops_threshold
  alarm_description   = "This metric monitors RDS read replica ReadIOPS"
  alarm_actions       = var.alarm_actions
  ok_actions          = var.alarm_actions

  dimensions = {
    DBInstanceIdentifier = aws_db_instance.read_replica[count.index].identifier
  }

  tags = local.common_tags
}

resource "aws_cloudwatch_metric_alarm" "write_io" {
  alarm_name          = "${local.name_prefix}-write-io"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = var.alarm_evaluation_periods
  metric_name         = "WriteIOPS"
  namespace           = "AWS/RDS"
  period              = var.alarm_period
  statistic           = "Average"
  threshold           = var.alarm_write_iops_threshold
  alarm_description   = "This metric monitors RDS WriteIOPS"
  alarm_actions       = var.alarm_actions
  ok_actions          = var.alarm_actions

  dimensions = {
    DBInstanceIdentifier = aws_db_instance.this.identifier
  }

  tags = local.common_tags
}

resource "aws_sns_topic" "rds_notifications" {
  count = var.create_sns_topic ? 1 : 0

  name = "${local.name_prefix}-notifications"

  tags = local.common_tags
}

resource "aws_rds_event_subscription" "this" {
  count = var.enable_event_subscription ? 1 : 0

  name          = "${local.name_prefix}-events"
  sns_topic_arn = aws_sns_topic.rds_notifications[0].arn

  source_type = "db-instance"

  event_categories = var.event_categories

  tags = local.common_tags
}