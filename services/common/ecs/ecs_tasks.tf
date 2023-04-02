resource "aws_cloudwatch_log_group" "ecs_loggroup" {
  name = "/ecs/${var.project}-${var.component}-${var.environment}"

  tags = {
    project     = var.project
    Name        = var.component
    environment = var.environment
  }
}


resource "aws_ecs_task_definition" "ecs_tsk" {
  family                = "${var.project}-${var.component}-${var.environment}-tsk"
  container_definitions = jsonencode([
    {
      name      = var.component
      image     = "${var.project}-${var.component}:latest"
      essential = true
      portMappings = [
        {
          containerPort = var.container_port
          hostPort      = var.container_port
          protocol      = "tcp"
        },
      ]
      logConfiguration = {
        logDriver = "awslogs"
        options = {
          "awslogs-group"         = aws_cloudwatch_log_group.ecs_loggroup.name
          "awslogs-region"        = "us-east-1"
          "awslogs-stream-prefix" = "ecs"
        }
      }
      environment = [
        for name, value in var.environment_variables : {
          name  = name
          value = value
        }
      ]
    },
  ])
  #container_definitions = data.template_file.container_definitions.rendered
  cpu                   = var.task_cpu
  execution_role_arn    = aws_iam_role.ecs_task_execution_role.arn
  #    id                       = "ecs-node-service"
  memory       = var.task_memory
  network_mode = "awsvpc"
  requires_compatibilities = [
    "FARGATE",
  ]
  #    revision                 = (aws_ecs_task_definition.ecs_node_service.revision+1) #18
  tags = {
    project     = var.project
    Name        = var.component
    environment = var.environment
    description = "This task is updated using terraform"
  }
  task_role_arn = aws_iam_role.ecs_task_execution_role.arn
}

resource "aws_iam_role" "ecs_task_execution_role" {
  name = "ecs-task-execution-role-${var.environment}"
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Principal = {
          Service = "ecs-tasks.amazonaws.com"
        }
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "ecs_task_execution_policy_attachment" {
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonECSTaskExecutionRolePolicy"
  role = aws_iam_role.ecs_task_execution_role.name
}

# data "external" "tags_of_most_recently_pushed_image" {
#   program = ["bash", "-c", <<-EOT
#     aws ecr describe-images \
#       --repository-name ${var.project}-${var.component} \
#       --query 'sort_by(imageDetails,& imagePushedAt)[-1].imageTags' \
#       --output json \
#       --region us-east-1
#   EOT
#   ]
# }
