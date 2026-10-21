locals {
  alarm_prefix        = "${var.project_name}-${var.environment}"
  dashboard_name      = "${var.project_name}-${var.environment}-dashboard"
  ecs_service_name    = var.ecs_cluster_name
  rds_instance_id     = var.rds_instance_id
}

resource "aws_cloudwatch_metric_alarm" "ecs_cpu_utilization_high" {
  alarm_name          = "${local.alarm_prefix}-ecs-cpu-high"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = 2
  metric_name         = "CPUUtilization"
  namespace           = "AWS/ECS"
  period              = 60
  statistic           = "Average"
  threshold           = var.ecs_cpu_threshold
  alarm_description   = "Alarma cuando la CPU del cluster ECS supera el umbral"
  alarm_actions       = [var.sns_topic_arn]
  ok_actions          = [var.sns_topic_arn]

  dimensions = {
    ClusterName = local.ecs_service_name
  }

  tags = {
    Name        = "${local.alarm_prefix}-ecs-cpu-high"
    Environment = var.environment
    Component   = "ecs-cluster"
    ManagedBy   = "terraform"
  }
}

resource "aws_cloudwatch_metric_alarm" "ecs_memory_utilization_high" {
  alarm_name          = "${local.alarm_prefix}-ecs-memory-high"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = 2
  metric_name         = "MemoryUtilization"
  namespace           = "AWS/ECS"
  period              = 60
  statistic           = "Average"
  threshold           = var.ecs_memory_threshold
  alarm_description   = "Alarma cuando la memoria del cluster ECS supera el umbral"
  alarm_actions       = [var.sns_topic_arn]
  ok_actions          = [var.sns_topic_arn]

  dimensions = {
    ClusterName = local.ecs_service_name
  }

  tags = {
    Name        = "${local.alarm_prefix}-ecs-memory-high"
    Environment = var.environment
    Component   = "ecs-cluster"
    ManagedBy   = "terraform"
  }
}

resource "aws_cloudwatch_metric_alarm" "ecs_service_cpu_utilization_high" {
  count               = length(var.ecs_service_names)
  alarm_name          = "${local.alarm_prefix}-ecs-service-cpu-high-${count.index}"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = 2
  metric_name         = "CPUUtilization"
  namespace           = "AWS/ECS"
  period              = 60
  statistic           = "Average"
  threshold           = var.ecs_service_cpu_threshold
  alarm_description   = "Alarma cuando la CPU del servicio ECS ${count.index} supera el umbral"
  alarm_actions       = [var.sns_topic_arn]
  ok_actions          = [var.sns_topic_arn]

  dimensions = {
    ClusterName = local.ecs_service_name
    ServiceName = var.ecs_service_names[count.index]
  }

  tags = {
    Name        = "${local.alarm_prefix}-ecs-service-cpu-high"
    Environment = var.environment
    Component   = "ecs-service"
    ManagedBy   = "terraform"
  }
}

resource "aws_cloudwatch_metric_alarm" "ecs_service_memory_utilization_high" {
  count               = length(var.ecs_service_names)
  alarm_name          = "${local.alarm_prefix}-ecs-service-memory-high-${count.index}"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = 2
  metric_name         = "MemoryUtilization"
  namespace           = "AWS/ECS"
  period              = 60
  statistic           = "Average"
  threshold           = var.ecs_service_memory_threshold
  alarm_description   = "Alarma cuando la memoria del servicio ECS ${count.index} supera el umbral"
  alarm_actions       = [var.sns_topic_arn]
  ok_actions          = [var.sns_topic_arn]

  dimensions = {
    ClusterName = local.ecs_service_name
    ServiceName = var.ecs_service_names[count.index]
  }

  tags = {
    Name        = "${local.alarm_prefix}-ecs-service-memory-high"
    Environment = var.environment
    Component   = "ecs-service"
    ManagedBy   = "terraform"
  }
}

resource "aws_cloudwatch_metric_alarm" "ecs_running_tasks_low" {
  alarm_name          = "${local.alarm_prefix}-ecs-running-tasks-low"
  comparison_operator = "LessThanThreshold"
  evaluation_periods  = 2
  metric_name         = "RunningTaskCount"
  namespace           = "AWS/ECS"
  period              = 60
  statistic           = "Average"
  threshold           = var.ecs_min_running_tasks
  alarm_description   = "Alarma cuando el número de tareas运行低于 el mínimo"
  alarm_actions       = [var.sns_topic_arn]
  ok_actions          = [var.sns_topic_arn]

  dimensions = {
    ClusterName = local.ecs_service_name
  }

  tags = {
    Name        = "${local.alarm_prefix}-ecs-running-tasks-low"
    Environment = var.environment
    Component   = "ecs-cluster"
    ManagedBy   = "terraform"
  }
}

resource "aws_cloudwatch_metric_alarm" "rds_cpu_utilization_high" {
  alarm_name          = "${local.alarm_prefix}-rds-cpu-high"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = 2
  metric_name         = "CPUUtilization"
  namespace           = "AWS/RDS"
  period              = 60
  statistic           = "Average"
  threshold           = var.rds_cpu_threshold
  alarm_description   = "Alarma cuando la CPU de RDS supera el umbral"
  alarm_actions       = [var.sns_topic_arn]
  ok_actions          = [var.sns_topic_arn]

  dimensions = {
    DBInstanceIdentifier = local.rds_instance_id
  }

  tags = {
    Name        = "${local.alarm_prefix}-rds-cpu-high"
    Environment = var.environment
    Component   = "rds-database"
    ManagedBy   = "terraform"
  }
}

resource "aws_cloudwatch_metric_alarm" "rds_memory_utilization_high" {
  alarm_name          = "${local.alarm_prefix}-rds-memory-high"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = 2
  metric_name         = "FreeableMemory"
  namespace           = "AWS/RDS"
  period              = 60
  statistic           = "Average"
  threshold           = var.rds_free_memory_threshold
  alarm_description   = "Alarma cuando la memoria libre de RDS está por debajo del umbral"
  alarm_actions       = [var.sns_topic_arn]
  ok_actions          = [var.sns_topic_arn]

  dimensions = {
    DBInstanceIdentifier = local.rds_instance_id
  }

  tags = {
    Name        = "${local.alarm_prefix}-rds-memory-high"
    Environment = var.environment
    Component   = "rds-database"
    ManagedBy   = "terraform"
  }
}

resource "aws_cloudwatch_metric_alarm" "rds_storage_utilization_high" {
  alarm_name          = "${local.alarm_prefix}-rds-storage-high"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = 2
  metric_name         = "DiskQueueDepth"
  namespace           = "AWS/RDS"
  period              = 60
  statistic           = "Average"
  threshold           = var.rds_storage_threshold
  alarm_description   = "Alarma cuando el almacenamiento de RDS supera el umbral"
  alarm_actions       = [var.sns_topic_arn]
  ok_actions          = [var.sns_topic_arn]

  dimensions = {
    DBInstanceIdentifier = local.rds_instance_id
  }

  tags = {
    Name        = "${local.alarm_prefix}-rds-storage-high"
    Environment = var.environment
    Component   = "rds-database"
    ManagedBy   = "terraform"
  }
}

resource "aws_cloudwatch_metric_alarm" "rds_connections_high" {
  alarm_name          = "${local.alarm_prefix}-rds-connections-high"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = 2
  metric_name         = "DatabaseConnections"
  namespace           = "AWS/RDS"
  period              = 60
  statistic           = "Average"
  threshold           = var.rds_connections_threshold
  alarm_description   = "Alarma cuando las conexiones a RDS superan el umbral"
  alarm_actions       = [var.sns_topic_arn]
  ok_actions          = [var.sns_topic_arn]

  dimensions = {
    DBInstanceIdentifier = local.rds_instance_id
  }

  tags = {
    Name        = "${local.alarm_prefix}-rds-connections-high"
    Environment = var.environment
    Component   = "rds-database"
    ManagedBy   = "terraform"
  }
}

resource "aws_cloudwatch_metric_alarm" "rds_read_iops_high" {
  alarm_name          = "${local.alarm_prefix}-rds-read-iops-high"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = 2
  metric_name         = "ReadIOPS"
  namespace           = "AWS/RDS"
  period              = 60
  statistic           = "Average"
  threshold           = var.rds_read_iops_threshold
  alarm_description   = "Alarma cuando los IOPS de lectura de RDS superan el umbral"
  alarm_actions       = [var.sns_topic_arn]
  ok_actions          = [var.sns_topic_arn]

  dimensions = {
    DBInstanceIdentifier = local.rds_instance_id
  }

  tags = {
    Name        = "${local.alarm_prefix}-rds-read-iops-high"
    Environment = var.environment
    Component   = "rds-database"
    ManagedBy   = "terraform"
  }
}

resource "aws_cloudwatch_metric_alarm" "rds_write_iops_high" {
  alarm_name          = "${local.alarm_prefix}-rds-write-iops-high"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = 2
  metric_name         = "WriteIOPS"
  namespace           = "AWS/RDS"
  period              = 60
  statistic           = "Average"
  threshold           = var.rds_write_iops_threshold
  alarm_description   = "Alarma cuando los IOPS de escritura de RDS superan el umbral"
  alarm_actions       = [var.sns_topic_arn]
  ok_actions          = [var.sns_topic_arn]

  dimensions = {
    DBInstanceIdentifier = local.rds_instance_id
  }

  tags = {
    Name        = "${local.alarm_prefix}-rds-write-iops-high"
    Environment = var.environment
    Component   = "rds-database"
    ManagedBy   = "terraform"
  }
}

resource "aws_cloudwatch_metric_alarm" "rds_replica_lag_high" {
  count               = var.enable_read_replica ? 1 : 0
  alarm_name          = "${local.alarm_prefix}-rds-replica-lag-high"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = 2
  metric_name         = "ReplicaLag"
  namespace           = "AWS/RDS"
  period              = 60
  statistic           = "Average"
  threshold           = var.rds_replica_lag_threshold
  alarm_description   = "Alarma cuando el lag de replicación de RDS supera el umbral"
  alarm_actions       = [var.sns_topic_arn]
  ok_actions          = [var.sns_topic_arn]

  dimensions = {
    DBInstanceIdentifier = local.rds_instance_id
  }

  tags = {
    Name        = "${local.alarm_prefix}-rds-replica-lag-high"
    Environment = var.environment
    Component   = "rds-database"
    ManagedBy   = "terraform"
  }
}

resource "aws_cloudwatch_metric_alarm" "rds_failover_metric" {
  alarm_name          = "${local.alarm_prefix}-rds-failover"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = 1
  metric_name         = "Failover"
  namespace           = "AWS/RDS"
  period              = 60
  statistic           = "Sum"
  threshold           = 1
  alarm_description   = "Alarma cuando ocurre un failover en RDS"
  alarm_actions       = [var.sns_topic_arn]
  ok_actions          = [var.sns_topic_arn]

  dimensions = {
    DBInstanceIdentifier = local.rds_instance_id
  }

  tags = {
    Name        = "${local.alarm_prefix}-rds-failover"
    Environment = var.environment
    Component   = "rds-database"
    ManagedBy   = "terraform"
  }
}

resource "aws_cloudwatch_log_group" "ecs_application_logs" {
  count             = var.enable_application_logs ? 1 : 0
  name              = "/ecs/${var.project_name}/${var.environment}/application"
  retention_in_days = var.log_retention_days
  kms_key_id        = var.logs_kms_key_arn
  tags = {
    Name        = "${local.alarm_prefix}-ecs-logs"
    Environment = var.environment
    Component   = "ecs-application"
    ManagedBy   = "terraform"
  }
}

resource "aws_cloudwatch_log_group" "ecs_audit_logs" {
  count             = var.enable_audit_logs ? 1 : 0
  name              = "/ecs/${var.project_name}/${var.environment}/audit"
  retention_in_days = var.log_retention_days
  kms_key_id        = var.logs_kms_key_arn
  tags = {
    Name        = "${local.alarm_prefix}-ecs-audit-logs"
    Environment = var.environment
    Component   = "ecs-audit"
    ManagedBy   = "terraform"
  }
}

resource "aws_cloudwatch_log_metric_filter" "ecs_error_filter" {
  count          = var.enable_application_logs ? 1 : 0
  name           = "${local.alarm_prefix}-ecs-errors"
  pattern        = "ERROR"
  log_group_name = aws_cloudwatch_log_group.ecs_application_logs[0].name

  metric_transformation {
    name      = "ErrorCount"
    namespace = "${var.project_name}/${var.environment}"
    value     = "1"
  }
}

resource "aws_cloudwatch_metric_alarm" "ecs_errors_alarm" {
  count          = var.enable_application_logs ? 1 : 0
  alarm_name     = "${local.alarm_prefix}-ecs-errors"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = 1
  metric_name    = "ErrorCount"
  namespace      = "${var.project_name}/${var.environment}"
  period         = 60
  statistic      = "Sum"
  threshold      = var.ecs_error_threshold
  alarm_description = "Alarma cuando se detectan errores en los logs de aplicación"
  alarm_actions  = [var.sns_topic_arn]
  ok_actions     = [var.sns_topic_arn]

  tags = {
    Name        = "${local.alarm_prefix}-ecs-errors"
    Environment = var.environment
    Component   = "ecs-application"
    ManagedBy   = "terraform"
  }
}

resource "aws_cloudwatch_dashboard" "main_dashboard" {
  dashboard_name = local.dashboard_name

  dashboard_body = jsonencode({
    widgets = [
      {
        type = "metric"
        properties = {
          metrics = [
            ["AWS/ECS", "CPUUtilization", { stat = "Average" }],
            [".", "MemoryUtilization", { stat = "Average" }],
            [{" color = "#ff7f7f", label = "CPU %" }, ".", "CPUUtilization", { stat = "Maximum" }],
            [{" color = "#7f7fff", label = "Memory %" }, ".", "MemoryUtilization", { stat = "Maximum" }]
          ]
          period = 60
          stat   = "Average"
          region = var.aws_region
          title  = "ECS Cluster Resource Utilization"
          annotations = {
            horizontal = [
              { value = var.ecs_cpu_threshold, label = "CPU Threshold", color = "#ff0000" },
              { value = var.ecs_memory_threshold, label = "Memory Threshold", color = "#0000ff" }
            ]
          }
          yAxis = {
            left = { min = 0, max = 100 }
          }
        }
      },
      {
        type = "metric"
        properties = {
          metrics = [
            ["AWS/ECS", "RunningTaskCount", { stat = "Maximum" }],
            ["AWS/ECS", "PendingTaskCount", { stat = "Maximum" }],
            ["AWS/ECS", "DesiredTaskCount", { stat = "Maximum" }]
          ]
          period = 60
          stat   = "Maximum"
          region = var.aws_region
          title  = "ECS Service Task Count"
          yAxis = {
            left = { min = 0 }
          }
        }
      },
      {
        type = "metric"
        properties = {
          metrics = [
            ["AWS/RDS", "CPUUtilization", { stat = "Average" }],
            ["AWS/RDS", "ReadIOPS", { stat = "Average" }],
            ["AWS/RDS", "WriteIOPS", { stat = "Average" }]
          ]
          period = 60
          stat   = "Average"
          region = var.aws_region
          title  = "RDS Performance Metrics"
          annotations = {
            horizontal = [
              { value = var.rds_cpu_threshold, label = "CPU Threshold", color = "#ff0000" }
            ]
          }
          yAxis = {
            left = { min = 0, max = 100 }
          }
        }
      },
      {
        type = "metric"
        properties = {
          metrics = [
            ["AWS/RDS", "DatabaseConnections", { stat = "Maximum" }],
            ["AWS/RDS", "FreeStorageSpace", { stat = "Minimum", label = "Free Storage (GB)" }]
          ]
          period = 60
          stat   = "Maximum"
          region = var.aws_region
          title  = "RDS Connections and Storage"
        }
      },
      {
        type = "metric"
        properties = {
          metrics = [
            ["AWS/ApplicationELB", "TargetResponseTime", { stat = "p95", label = "p95 Response Time" }],
            ["AWS/ApplicationELB", "TargetResponseTime", { stat = "p99", label = "p99 Response Time" }],
            ["AWS/ApplicationELB", "TargetResponseTime", { stat = "Average", label = "Average Response Time" }]
          ]
          period = 60
          stat   = "Average"
          region = var.aws_region
          title  = "ALB Response Time"
          yAxis = {
            left = { min = 0 }
          }
        }
      },
      {
        type = "metric"
        properties = {
          metrics = [
            ["AWS/ApplicationELB", "RequestCountPerTarget", { stat = "Sum", label = "Requests per Target" }],
            ["AWS/ApplicationELB", "HealthyHostCount", { stat = "Maximum", label = "Healthy Hosts" }],
            ["AWS/ApplicationELB", "UnhealthyHostCount", { stat = "Maximum", label = "Unhealthy Hosts", color = "#ff0000" }]
          ]
          period = 60
          stat   = "Sum"
          region = var.aws_region
          title  = "ALB Request Distribution"
        }
      },
      {
        type = "metric"
        properties = {
          metrics = [
            ["AWS/ApplicationELB", "HTTPCode_Target_5XX_Count", { stat = "Sum", color = "#ff0000", label = "5XX Errors" }],
            ["AWS/ApplicationELB", "HTTPCode_Target_4XX_Count", { stat = "Sum", color = "#ff8800", label = "4XX Errors" }],
            ["AWS/ApplicationELB", "HTTPCode_Target_2XX_Count", { stat = "Sum", color = "#00ff00", label = "2XX Success" }]
          ]
          period = 60
          stat   = "Sum"
          region = var.aws_region
          title  = "ALB HTTP Response Codes"
        }
      },
      {
        type = "log"
        properties = {
          query = "SOURCE '/ecs/${var.project_name}/${var.environment}/application' | filter @message like /ERROR/ | stats count() as ErrorCount by bin(1m)"
          region = var.aws_region
          title  = "Application Error Rate"
        }
      }
    ]
  })

  tags = {
    Name        = local.dashboard_name
    Environment = var.environment
    Project     = var.project_name
    ManagedBy   = "terraform"
  }
}

resource "aws_cloudwatch_dashboard" "rds_dashboard" {
  dashboard_name = "${local.dashboard_name}-rds"

  dashboard_body = jsonencode({
    widgets = [
      {
        type = "metric"
        properties = {
          metrics = [
            ["AWS/RDS", "CPUUtilization", { stat = "Average" }],
            ["AWS/RDS", "CPUUtilization", { stat = "Maximum", color = "#ff0000" }]
          ]
          period = 60
          stat   = "Average"
          region = var.aws_region
          title  = "RDS CPU Utilization"
          annotations = {
            horizontal = [
              { value = var.rds_cpu_threshold, label = "Threshold", color = "#ff0000" }
            ]
          }
          yAxis = {
            left = { min = 0, max = 100 }
          }
        }
      },
      {
        type = "metric"
        properties = {
          metrics = [
            ["AWS/RDS", "ReadIOPS", { stat = "Average", label = "Read IOPS" }],
            ["AWS/RDS", "WriteIOPS", { stat = "Average", label = "Write IOPS" }]
          ]
          period = 60
          stat   = "Average"
          region = var.aws_region
          title  = "RDS IOPS"
          yAxis = {
            left = { min = 0 }
          }
        }
      },
      {
        type = "metric"
        properties = {
          metrics = [
            ["AWS/RDS", "DatabaseConnections", { stat = "Maximum" }],
            ["AWS/RDS", "DatabaseConnections", { stat = "Average" }]
          ]
          period = 60
          stat   = "Maximum"
          region = var.aws_region
          title  = "RDS Database Connections"
          annotations = {
            horizontal = [
              { value = var.rds_connections_threshold, label = "Threshold", color = "#ff0000" }
            ]
          }
        }
      },
      {
        type = "metric"
        properties = {
          metrics = [
            ["AWS/RDS", "FreeStorageSpace", { stat = "Minimum", label = "Free Space (GB)" }]
          ]
          period = 60
          stat   = "Minimum"
          region = var.aws_region
          title  = "RDS Free Storage"
        }
      },
      {
        type = "metric"
        properties = {
          metrics = [
            ["AWS/RDS", "ReadLatency", { stat = "Average", label = "Read Latency (ms)" }],
            ["AWS/RDS", "WriteLatency", { stat = "Average", label = "Write Latency (ms)" }]
          ]
          period = 60
          stat   = "Average"
          region = var.aws_region
          title  = "RDS Latency"
          yAxis = {
            left = { min = 0 }
          }
        }
      },
      {
        type = "metric"
        properties = {
          metrics = [
            ["AWS/RDS", "ReplicaLag", { stat = "Maximum", color = "#ff0000" }]
          ]
          count  = var.enable_read_replica ? 1 : 0
          period = 60
          stat   = "Maximum"
          region = var.aws_region
          title  = "RDS Replica Lag"
          annotations = {
            horizontal = [
              { value = var.rds_replica_lag_threshold, label = "Threshold", color = "#ff0000" }
            ]
          }
        }
      }
    ]
  })

  count = var.enable_read_replica ? 1 : 0

  tags = {
    Name        = "${local.dashboard_name}-rds"
    Environment = var.environment
    Project     = var.project_name
    ManagedBy   = "terraform"
  }
}