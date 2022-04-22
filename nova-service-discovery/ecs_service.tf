resource "aws_ecs_service" "ecs_svc" {
  depends_on = [
    aws_ecs_task_definition.ecs_tsk,
    aws_lb_target_group.ecs_tg
  ]
  cluster                            = data.aws_ecs_cluster.ecs_cluster.arn
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
  name                = "${var.environment}-${var.project}-${var.project_component}-svc"
  platform_version    = "LATEST"
  propagate_tags      = "SERVICE"
  scheduling_strategy = "REPLICA"
  tags = {
    createdby   = var.createdby
    project     = var.project
    Name        = var.project_component
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
    container_name   = var.project_component
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
    subnets = [for s in data.aws_subnet.ecs_subnets : s.id]
  }

  service_registries {
    #        container_port = 8881
    # #        port           = 
    registry_arn = aws_service_discovery_service.service_discovery.arn
  }

  timeouts {}
}

resource "aws_service_discovery_service" "service_discovery" {
  description = "Service discovery for ${var.project_component} service"
  dns_config {
    dns_records {
      ttl  = 60
      type = "A"
    }
    namespace_id   = (var.environment == "prod" ? "ns-d3vkujubmpshovvl" : var.environment == "stg" ? "ns-e4oojsomufujo22k" : "ns-72zvjzakwsrj6bxw")
    routing_policy = "MULTIVALUE"
  }
  health_check_custom_config {
    failure_threshold = 1
  }
  name = "${var.environment}-${var.project}-${var.project_component}"
  tags = {
    createdby   = var.createdby
    project     = var.project
    Name        = var.project_component
    environment = var.environment
    description = "This task is updated using terraform"
  }
}
