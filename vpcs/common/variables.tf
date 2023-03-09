variable "name" {
  type        = string
  description = "Name of the VPC (e.g. `pa`, `railsafe`)"
}

variable "cluster_name" {
  type        = string
  default     = ""
  description = "Name of the EKS cluster. If blank, the cluster's name is assumed to be the VPCs name"
}

variable "enable_flow_log" {
  type        = bool
  default     = true
  description = "Enable VPC flow logs"
}

variable "create_elasticache_subnets" {
  type        = bool
  default     = false
  description = "Create Elasticache subnets"

}
