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
  default = "https://github.com/seamfix/nibbs-mock-service.git"
}

variable "repo_branch" {
  default = "staging-dev"
}
