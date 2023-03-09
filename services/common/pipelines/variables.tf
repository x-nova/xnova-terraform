variable "project" {
  type = string
}

variable "environment" {
  type = string
}

variable "component" {
  type = string
}

variable "codebuild_role" {
  default = "scripts/codebuild_role.json"
}

variable "codebuild_role_policy" {
  default = "scripts/codebuild_role_policy.json"
}

variable "buildspec_java" {
  default = "scripts/buildspec-java.yaml"
}

variable "buildspec_node" {
  default = "scripts/buildspec-node.yaml"
}

variable "code_repo" {
  type = string
}

variable "codepipeline_role" {
  default = "scripts/codepipeline_role.json"
}

variable "codepipeline_role_policy" {
  default = "scripts/codepipeline_role_policy.json"
}

variable "region" {
  type = string
  default = "us-east-1"
}

variable "tech" {
  type = string
}
