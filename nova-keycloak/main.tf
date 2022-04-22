terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.0"
    }
  }
  backend "remote" {
    organization = "sfx-${var.project}"
    hostname     = "app.terraform.io"

    workspaces {
      name = "${var.enviornment}-${var.project}-${var.project_element}"
    }
  }

}

provider "aws" {
  region     = var.region
  access_key = var.access_key
  secret_key = var.secret_key
}

