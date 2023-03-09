variable "repository_name" {
  type        = string
  description = "Name of the ECR repository to be created"
}

variable "create_lifecycle_policy" {
  type        = bool
  default     = true
  description = "Determines whether a lifecycle policy should limit the repository to 500 images"
}
