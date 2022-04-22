variable "region" {
  type        = string
  description = "The AWS region for the infrastructure"
}

variable "access_key" {
  type        = string
  description = "The AWS access key for the infrastructure"
}

variable "secret_key" {
  type        = string
  description = "The AWS secret key for the infrastructure"
  sensitive   = true
}
