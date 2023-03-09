resource "aws_codepipeline" "ecs_codepipeline_project" {
  depends_on = [aws_codebuild_project.this]
  name       = "${var.project}-${var.component}-${var.environment}"
  role_arn   = aws_iam_role.ecs_codepipeline.arn

  artifact_store {
    location = "${var.project}-${var.environment}-codepipeline"
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
        ConnectionArn    = data.aws_codestarconnections_connection.this.arn
        FullRepositoryId = regex("github.com/(.*)\\.git", var.code_repo)[0]
        BranchName       = (var.environment == "production" ? "main" : var.environment == "staging" ? "staging" : "dev")
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
        ProjectName = aws_codebuild_project.this.name
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
        ClusterName       = "${var.project}-${var.environment}-cluster"
        ServiceName       = "${var.project}-${var.component}-${var.environment}-svc"
        FileName          = "imagedefinitions.json"
        DeploymentTimeout = "30"
      }
    }
  }
}


data "aws_codestarconnections_connection" "this" {
  arn = var.environment == "production" ? "arn:aws:codestar-connections:us-east-1:286458283644:connection/50b32dca-9160-4f0e-a053-a630ec04bc24" : "arn:aws:codestar-connections:us-east-1:613930993078:connection/f91be0bb-1fc5-4718-8682-58d8256ce144"
}



resource "aws_iam_role" "ecs_codepipeline" {
  name = "${var.project}-${var.component}-${var.environment}-codepipeline-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Principal = {
          Service = "codepipeline.amazonaws.com"
        }
        Action = "sts:AssumeRole"
      }
    ]
  })
}

resource "aws_iam_role_policy" "codepipeline_policy" {
  name = "${var.project}-${var.component}-${var.environment}-codepipeline_policy"
  role = aws_iam_role.ecs_codepipeline.name

  policy = jsonencode({
    "Statement": [
      {
        "Action": ["iam:PassRole"],
        "Resource": "*",
        "Effect": "Allow",
        "Condition": {
          "StringEqualsIfExists": {
            "iam:PassedToService": [
              "cloudformation.amazonaws.com",
              "elasticbeanstalk.amazonaws.com",
              "ec2.amazonaws.com",
              "ecs-tasks.amazonaws.com"
            ]
          }
        }
      },
      {
        "Action": [
          "codecommit:CancelUploadArchive",
          "codecommit:GetBranch",
          "codecommit:GetCommit",
          "codecommit:GetRepository",
          "codecommit:GetUploadArchiveStatus",
          "codecommit:UploadArchive"
        ],
        "Resource": "*",
        "Effect": "Allow"
      },
      {
        "Action": [
          "codedeploy:CreateDeployment",
          "codedeploy:GetApplication",
          "codedeploy:GetApplicationRevision",
          "codedeploy:GetDeployment",
          "codedeploy:GetDeploymentConfig",
          "codedeploy:RegisterApplicationRevision"
        ],
        "Resource": "*",
        "Effect": "Allow"
      },
      {
        "Action": ["codestar-connections:UseConnection"],
        "Resource": "*",
        "Effect": "Allow"
      },
      {
        "Action": [
          "elasticbeanstalk:*",
          "ec2:*",
          "elasticloadbalancing:*",
          "autoscaling:*",
          "cloudwatch:*",
          "s3:*",
          "sns:*",
          "cloudformation:*",
          "rds:*",
          "sqs:*",
          "ecs:*"
        ],
        "Resource": "*",
        "Effect": "Allow"
      },
      {
        "Action": ["lambda:InvokeFunction", "lambda:ListFunctions"],
        "Resource": "*",
        "Effect": "Allow"
      },
      {
        "Action": [
          "opsworks:CreateDeployment",
          "opsworks:DescribeApps",
          "opsworks:DescribeCommands",
          "opsworks:DescribeDeployments",
          "opsworks:DescribeInstances",
          "opsworks:DescribeStacks",
          "opsworks:UpdateApp",
          "opsworks:UpdateStack"
        ],
        "Resource": "*",
        "Effect": "Allow"
      },
      {
        "Action": [
          "cloudformation:CreateStack",
          "cloudformation:DeleteStack",
          "cloudformation:DescribeStacks",
          "cloudformation:UpdateStack",
          "cloudformation:CreateChangeSet",
          "cloudformation:DeleteChangeSet",
          "cloudformation:DescribeChangeSet",
          "cloudformation:ExecuteChangeSet",
          "cloudformation:SetStackPolicy",
          "cloudformation:ValidateTemplate"
        ],
        "Resource": "*",
        "Effect": "Allow"
      },
      {
        "Action": [
          "codebuild:BatchGetBuilds",
          "codebuild:StartBuild",
          "codebuild:BatchGetBuildBatches",
          "codebuild:StartBuildBatch"
        ],
        "Resource": "*",
        "Effect": "Allow"
      },
      {
        Effect   = "Allow",
        Action   = [
          "devicefarm:ListProjects",
          "devicefarm:ListDevicePools",
          "devicefarm:GetRun",
          "devicefarm:GetUpload",
          "devicefarm:CreateUpload",
          "devicefarm:ScheduleRun"
        ],
        Resource = "*"
      },
      {
        Effect   = "Allow",
        Action   = [
          "servicecatalog:ListProvisioningArtifacts",
          "servicecatalog:CreateProvisioningArtifact",
          "servicecatalog:DescribeProvisioningArtifact",
          "servicecatalog:DeleteProvisioningArtifact",
          "servicecatalog:UpdateProduct"
        ],
        Resource = "*"
      },
      {
        Effect   = "Allow",
        Action   = ["cloudformation:ValidateTemplate"],
        Resource = "*"
      },
      {
        Effect   = "Allow",
        Action   = ["ecr:DescribeImages"],
        Resource = "*"
      },
      {
        Effect   = "Allow",
        Action   = [
          "states:DescribeExecution",
          "states:DescribeStateMachine",
          "states:StartExecution"
        ],
        Resource = "*"
      },
      {
        Effect   = "Allow",
        Action   = [
          "appconfig:StartDeployment",
          "appconfig:StopDeployment",
          "appconfig:GetDeployment"
        ],
        Resource = "*"
      }
    ],
    Version   = "2012-10-17"
  })
}
