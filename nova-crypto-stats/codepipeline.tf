resource "aws_codepipeline" "ecs_codepipeline_project" {
  depends_on = [aws_codebuild_project.ecs_codebuild_project]
  name       = "${var.environment}-${var.project}-${var.project_component}"
  role_arn   = aws_iam_role.ecs_codepipeline.arn

  artifact_store {
    location = (var.environment == "prod" ? "codepipeline-us-east-1-416492527919" : var.environment == "stg" ? "codepipeline-us-east-1-416492527919" : "codepipeline-us-east-1-416492527919")
    type     = "S3"
  }

  stage {
    name = "Source"

    action {
      name             = "Source"
      category         = "Source"
      owner            = "AWS"
      provider         = "CodeStarSourceConnection"
      version          = "1"
      output_artifacts = ["source_output"]

      configuration = {
        ConnectionArn    = data.aws_codestarconnections_connection.ecs_codepipeline.arn
        FullRepositoryId = var.repo_id
        BranchName       = (var.environment == "prod" ? "master" : var.environment == "stg" ? "stg" : "dev")
      }
    }
  }

  stage {
    name = "Build"

    action {
      name             = "Build"
      category         = "Build"
      owner            = "AWS"
      provider         = "CodeBuild"
      input_artifacts  = ["source_output"]
      output_artifacts = ["build_output"]
      version          = "1"

      configuration = {
        ProjectName = aws_codebuild_project.ecs_codebuild_project.name
      }
    }
  }

  stage {
    name = "Deploy"

    action {
      name            = "Deploy"
      category        = "Deploy"
      owner           = "AWS"
      provider        = "ECS"
      input_artifacts = ["build_output"]
      version         = "1"

      configuration = {
        ClusterName       = "${data.aws_ecs_cluster.ecs_cluster.cluster_name}"
        ServiceName       = aws_ecs_service.ecs_svc.name
        FileName          = "imagedefinitions.json"
        DeploymentTimeout = "30"
      }
    }
  }
}

# resource "aws_codestarconnections_connection" "github_connection" {
#   name          = "example-connection"
#   provider_type = "GitHub"
# }

data "aws_codestarconnections_connection" "ecs_codepipeline" {
  arn = "arn:aws:codestar-connections:us-east-1:437622698243:connection/d350c8ad-e84e-4528-8f1f-eb22ce6aad64"
}



resource "aws_iam_role" "ecs_codepipeline" {
  name = "${var.environment}-${var.project}-${var.project_component}-codepipeline-role"

  assume_role_policy = data.template_file.codepipeline_role.rendered
}

data "template_file" "codepipeline_role" {
  template = file("${var.codepipeline_role}")
}

resource "aws_iam_role_policy" "codepipeline_policy" {
  name = "${var.environment}-${var.project}-${var.project_component}-codepipeline_policy"
  role = aws_iam_role.ecs_codepipeline.name

  policy = data.template_file.codepipeline_role_policy.rendered
}

data "template_file" "codepipeline_role_policy" {
  template = file("${var.codepipeline_role_policy}")
}
