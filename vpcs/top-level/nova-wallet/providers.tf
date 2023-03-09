terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.3"
    }
  }
}
provider "aws" {
  profile = local.aws_profile
  region  = "us-east-1"
}
