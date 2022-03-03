resource "aws_cloudwatch_log_group" "ecs_loggroup" {
  name = "/ecs/${var.environment}-${var.project}-${var.project_component}"

  tags = {
    createdby   = var.createdby
    project     = var.project
    Name        = var.project_component
    environment = var.environment
  }
}


resource "aws_ecs_task_definition" "ecs_tsk" {
  family                = "${var.environment}-${var.project}-${var.project_component}-tsk"
  container_definitions = data.template_file.container_definitions.rendered
  cpu                   = var.task_cpu
  execution_role_arn    = "arn:aws:iam::437622698243:role/ecsTaskExecutionRole"
  #    id                       = "ecs-node-service"
  memory       = var.task_memory
  network_mode = "awsvpc"
  requires_compatibilities = [
    "FARGATE",
  ]
  #    revision                 = (aws_ecs_task_definition.ecs_node_service.revision+1) #18
  tags = {
    createdby   = var.createdby
    project     = var.project
    Name        = var.project_component
    environment = var.environment
    description = "This task is updated using terraform"
  }
  task_role_arn = "arn:aws:iam::437622698243:role/ecsTaskExecutionRole"
}

data "template_file" "container_definitions" {
  template = file("${var.container_definitions}")
  vars = {
    ecr_repo_url   = aws_ecr_repository.ecs.repository_url
    image_id       = (jsondecode(data.external.tags_of_most_recently_pushed_image.result.tags) == null ? "latest" : jsondecode(data.external.tags_of_most_recently_pushed_image.result.tags)[0])
    loggroup       = aws_cloudwatch_log_group.ecs_loggroup.name
    region         = var.region
    task_name      = var.project_component
    container_port = var.container_port

  }
}
