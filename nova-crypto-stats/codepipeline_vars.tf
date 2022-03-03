variable "repo_id" {
  default = "seamfix/nibbs-mock-service"
}

variable "codepipeline_role" {
  default = "scripts/codepipeline_role.json"
}

variable "codepipeline_role_policy" {
  default = "scripts/codepipeline_role_policy.json"
}
