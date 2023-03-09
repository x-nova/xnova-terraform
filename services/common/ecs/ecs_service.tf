resource "aws_ecs_service" "ecs_svc" {
  depends_on = [
    aws_ecs_task_definition.ecs_tsk,
    aws_lb_target_group.ecs_tg
  ]
  cluster                            = "${var.project}-${var.environment}-cluster"
  deployment_maximum_percent         = 200
  deployment_minimum_healthy_percent = 100
  desired_count                      = 1
  enable_ecs_managed_tags            = true
  enable_execute_command             = true
  health_check_grace_period_seconds  = var.health_check_grace_period_seconds
  wait_for_steady_state              = false
  #    iam_role                           = "aws-service-role"
  #    id                                 = "arn:aws:ecs:us-east-1:341481854267:service/stg-ecs-cluster/stg-ecs-node-svc"
  launch_type         = "FARGATE"
  name                = "${var.project}-${var.component}-${var.environment}-svc"
  platform_version    = "LATEST"
  propagate_tags      = "SERVICE"
  scheduling_strategy = "REPLICA"
  tags = {
    project     = var.project
    Name        = var.component
    environment = var.environment
    description = "This task is updated using terraform"
  }
  task_definition = aws_ecs_task_definition.ecs_tsk.arn

  deployment_circuit_breaker {
    enable   = true
    rollback = true
  }

  deployment_controller {
    type = "ECS"
  }

  load_balancer {
    container_name   = var.component
    container_port   = var.container_port
    target_group_arn = aws_lb_target_group.ecs_tg.arn
  }

  lifecycle {
    ignore_changes = [desired_count]
  }

  network_configuration {
    assign_public_ip = true
    security_groups = [
      aws_security_group.ecs_svc_sg.id,
    ]
    #for_each = data.aws_subnet_ids.ecs_vpc_subnets.ids
    subnets = var.ecs_subnets
  }

  service_registries {
    registry_arn = aws_service_discovery_service.service_discovery.arn
  }
  timeouts {}
}

data "aws_service_discovery_dns_namespace" "this" {
  name        = var.environment == "production" ? "api.novawallet.exchange" : var.environment == "staging" ? "api.stg.novawallet.exchange" : "api.dev.novawallet.exchange"
  type = "DNS_PUBLIC"
}

resource "aws_service_discovery_service" "service_discovery" {
  description = "Service discovery for ${var.component} service"
  dns_config {
    dns_records {
      ttl  = 60
      type = "A"
    }
    namespace_id   = data.aws_service_discovery_dns_namespace.this.id
  }
  health_check_custom_config {
    failure_threshold = 1
  }
  name = "${var.project}-${var.component}-${var.environment}"
  tags = {
    project     = var.project
    Name        = var.component
    environment = var.environment
    description = "This task is updated using terraform"
  }
}

resource "aws_appautoscaling_target" "ecs_memory" {
  max_capacity       = var.max_capacity
  min_capacity       = var.min_capacity
  resource_id        = "service/${var.project}-${var.environment}-cluster/${aws_ecs_service.ecs_svc.name}"
  scalable_dimension = "ecs:service:DesiredCount"
  service_namespace  = "ecs"
}

resource "aws_appautoscaling_policy" "ecs_memory" {
  name               = "${aws_ecs_service.ecs_svc.name}-memory-policy"
  policy_type        = "StepScaling"
  resource_id        = "${aws_appautoscaling_target.ecs_memory.resource_id}"
  scalable_dimension = "${aws_appautoscaling_target.ecs_memory.scalable_dimension}"
  service_namespace  = "${aws_appautoscaling_target.ecs_memory.service_namespace}"

  step_scaling_policy_configuration {
    adjustment_type         = "ChangeInCapacity"
    cooldown                = 300
    metric_aggregation_type = "Average"

    step_adjustment {
      scaling_adjustment = 1
      metric_interval_lower_bound = 0
      metric_interval_upper_bound = 50
    }

    step_adjustment {
      scaling_adjustment = 2
      metric_interval_lower_bound = 50
      metric_interval_upper_bound = 75
    }

    step_adjustment {
      scaling_adjustment = 3
      metric_interval_lower_bound = 75
    }
  }

  depends_on = [
    aws_appautoscaling_target.ecs_memory
  ]
}

resource "aws_cloudwatch_metric_alarm" "ecs_memory" {
  alarm_name          = "ecs-memory-alarm"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = 2
  metric_name         = "MemoryReservation"
  namespace           = "AWS/ECS"
  period              = 60
  statistic           = "Average"
  threshold           = var.target_memory
  alarm_description   = "This metric monitors memory utilization for the ${aws_ecs_service.ecs_svc.name} service."
  alarm_actions       = [aws_appautoscaling_policy.ecs_memory.arn]

  dimensions = {
    ClusterName = "${var.project}-${var.environment}-cluster"
    ServiceName = aws_ecs_service.ecs_svc.name
  }
}

