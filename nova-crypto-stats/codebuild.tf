
resource "aws_iam_role" "ecs_codebuild" {
  name = "${var.environment}-${var.project}-${var.project_component}-role"

  assume_role_policy = data.template_file.codebuild_role.rendered

}

data "template_file" "codebuild_role" {
  template = file("${var.codebuild_role}")
}


resource "aws_iam_role_policy" "ecs-role-policy" {
  role = aws_iam_role.ecs_codebuild.name

  policy = data.template_file.codebuild_role_policy.rendered
}

data "template_file" "codebuild_role_policy" {
  template = file("${var.codebuild_role_policy}")
}

resource "aws_codebuild_project" "ecs_codebuild_project" {
  depends_on    = [aws_ecs_service.ecs_svc, aws_ecr_repository.ecs]
  name          = "${var.environment}-${var.project}-${var.project_component}"
  description   = "Build project for ${var.project_component} for ${var.project} on ${var.environment}"
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
      group_name  = "/codebuild/${var.environment}-${var.project}-${var.project_component}"
      stream_name = "${var.project_component}-build"
    }

    s3_logs {
      status = "DISABLED"
    }
  }

  source {
    type            = "GITHUB"
    location        = var.code_repo
    git_clone_depth = 1
    buildspec       = data.template_file.buildspec.rendered

    git_submodules_config {
      fetch_submodules = true
    }
  }

  source_version = (var.environment == "prod" ? "master" : var.environment == "stg" ? "snapshot" : "staging-dev")

  tags = {
    createdby   = var.createdby
    project     = var.project
    Name        = var.project_component
    environment = var.environment
    description = "This task is updated using terraform"
  }
}

data "template_file" "buildspec" {
  template = (var.tech == "java" ? file("${var.buildspec_java}") : file("${var.buildspec_node}")) #file("${var.buildspec}")
  vars = {
    ecr_repo_url = aws_ecr_repository.ecs.repository_url
    loggroup     = aws_cloudwatch_log_group.ecs_loggroup.name
    region       = var.region
    task_name    = var.project_component
    image_name   = "${var.environment}-${var.project}/${var.project_component}"
  }
}
