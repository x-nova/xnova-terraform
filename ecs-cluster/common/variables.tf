variable "environment" {
  type        = string
  description = "The environment name"
}
  
variable "project" {
  type        = string
  description = "The project name"
}

variable "vpc_id" {
  type        = string
  description = "The VPC to deploy into"
}

variable "public_subnets" {
  type        = list(string)
  description = "The public subnets to deploy into"
}
