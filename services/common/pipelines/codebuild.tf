locals {
  buildspec_content = {
    java = templatefile("${path.module}/scripts/buildspec-java.yaml", {
      ecr_repo_url = aws_ecr_repository.ecs.repository_url
      region       = var.region
      task_name    = var.component
      image_name   = "${var.project}-${var.component}-${var.environment}"
    })
    node = templatefile("${path.module}/scripts/buildspec-node.yaml", {
      ecr_repo_url = aws_ecr_repository.ecs.repository_url
      region       = var.region
      task_name    = var.component
      image_name   = "${var.project}-${var.component}-${var.environment}"
    })
  }
}


resource "aws_iam_role" "ecs_codebuild" {
  name = "${var.project}-${var.component}-${var.environment}-codebuild-role"
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect: "Allow"
        Principal: {
          Service: "codebuild.amazonaws.com"
        }
        Action: "sts:AssumeRole"
      }
    ]
  })
}

resource "aws_iam_role_policy" "ecs-role-policy" {
  role = aws_iam_role.ecs_codebuild.name

  policy =  jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Resource = ["*"]
        Action = [
          "logs:CreateLogGroup",
          "logs:CreateLogStream",
          "logs:PutLogEvents"
        ]
      },
      {
        Effect = "Allow"
        Action = [
          "ec2:CreateNetworkInterface",
          "ec2:DescribeDhcpOptions",
          "ec2:DescribeNetworkInterfaces",
          "ec2:DeleteNetworkInterface",
          "ec2:DescribeSubnets",
          "ec2:DescribeSecurityGroups",
          "ec2:DescribeVpcs"
        ]
        Resource = "*"
      },
      {
        Effect = "Allow"
        Action = ["s3:*"]
        Resource = "*"
      },
      {
        Effect = "Allow"
        Action = ["ecr:*", "cloudtrail:LookupEvents"]
        Resource = "*"
      },
      {
        Effect = "Allow"
        Action = ["iam:CreateServiceLinkedRole"]
        Resource = "*"
        Condition = {
          StringEquals = {
            "iam:AWSServiceName" = ["replication.ecr.amazonaws.com"]
          }
        }
      }
    ]
  })
}

resource "aws_codebuild_project" "this" {
  name          = "${var.project}-${var.component}-${var.environment}"
  description   = "Build project for ${var.component} for ${var.project} on ${var.environment}"
  service_role  = aws_iam_role.ecs_codebuild.arn
  badge_enabled = false

  artifacts {
    type = "NO_ARTIFACTS"
  }

  cache {
    type = "NO_CACHE"
  }

  environment {
    compute_type                = "BUILD_GENERAL1_SMALL"
    image                       = "aws/codebuild/amazonlinux2-x86_64-standard:3.0"
    type                        = "LINUX_CONTAINER"
    image_pull_credentials_type = "CODEBUILD"
    privileged_mode             = true
  }

  logs_config {
    cloudwatch_logs {
      group_name  = "/codebuild/${var.project}-${var.component}-${var.environment}"
      stream_name = "${var.component}-build"
    }

    s3_logs {
      status = "DISABLED"
    }
  }

  source {
    type            = "GITHUB"
    location        = var.code_repo
    git_clone_depth = 1
    buildspec       = var.tech == "java" ? local.buildspec_content.java : local.buildspec_content.node

    git_submodules_config {
      fetch_submodules = true
    }
  }

  source_version = (var.environment == "production" ? "main" : var.environment == "staging" ? "staging" : "dev")

  tags = {
    Project     = var.project
    Name        = var.component
    Environment = var.environment
  }
}

# data "template_file" "buildspec" {
#   template = (var.tech == "java" ? file("${var.buildspec_java}") : file("${var.buildspec_node}")) #file("${var.buildspec}")
#   vars = {
#     ecr_repo_url = aws_ecr_repository.ecs.repository_url
#     region       = var.region
#     task_name    = var.component
#     image_name   = "${var.project}-${var.component}-${var.environment}"
#   }
# }
