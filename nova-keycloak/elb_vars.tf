variable "elb_arn" {
  default = "arn:aws:elasticloadbalancing:us-east-1:341481854267:loadbalancer/app/dev-verified-lb/485b4f350096c247"
}

variable "elb_name" {
  default = "dev-verified-lb"
}

variable "health_check" {
  default = "true"
}

variable "health_check_path" {
  default = "/nibss/bvn/health"
}

variable "listener_rule_pattern" {
  type    = list(string)
  default = ["/nibss"]
}

