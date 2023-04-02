locals {
  aws_profile = {
    production = "nova-wallet-production"
    nonprod    = "nova-wallet-nonprod"
  }[terraform.workspace]
    environment = terraform.workspace
}

# Create an IAM user for GitHub Actions
resource "aws_iam_user" "github" {
  name = "github-bot-${local.environment}"
}

# Create an IAM policy for the GitHub Actions user
resource "aws_iam_policy" "github" {
  name        = "github"
  description = "GitHub Actions policy"
  policy      = data.aws_iam_policy_document.github.json
}

# Create an IAM policy document for the GitHub Actions user for ECS, ECR
data "aws_iam_policy_document" "github" {
  statement {
    actions = [
        "ecr:*",
        "ecs:*",
        "iam:PassRole",
        "logs:*",
    ]
    resources = ["*"]
    }
}

# Attach the policy to the GitHub Actions user
resource "aws_iam_user_policy_attachment" "github" {
  user       = aws_iam_user.github.name
  policy_arn = aws_iam_policy.github.arn
}


# resource "aws_iam_role" "github_actions_role" {
#   name = "GitHubActionsRole"

#   assume_role_policy = jsonencode({
#     Version = "2012-10-17"
#     Statement = [
#       {
#         Action = "sts:AssumeRole"
#         Effect = "Allow"
#         Principal = {
#           Service = "codebuild.amazonaws.com"
#         }
#       }
#     ]
#   })
# }

# resource "aws_iam_role_policy_attachment" "github_actions_role_policy" {
#   policy_arn = aws_iam_policy.github.arn
#   role       = aws_iam_role.github_actions_role.name
# }