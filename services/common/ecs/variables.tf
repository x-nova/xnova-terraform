variable "project" {
  type = string
}

variable "environment" {
  type = string
}

variable "component" {
  type = string
}

variable "container_port" {
  type = number
  default = 8000
}

variable "environment_variables" {
  type = map(string)
  default = {
    "KEY" = "value"
  }
}

variable "task_cpu" {
  default = "256"
}

variable "task_memory" {
  default = "512"
}

variable "health_check" {
  type    = bool
  default = true
}

variable "health_check_path" {
  type    = string
  default = "/"
}

variable "health_check_grace_period_seconds" {
  type    = number
  default = 60
}

variable "health_check_ping_interval" {
  type    = number
  default = 90
}

variable "unhealthy_threshold" {
  type    = number
  default = 5
}

variable "ecs_subnets" {
  type   = list(string)
  default = []
}

variable "max_capacity" {
  type    = number
  default = 10
}

variable "min_capacity" {
  type    = number
  default = 2
}

variable "target_memory" {
  type    = number
  default = 70
}

variable "scale_in_cooldown" {
  type    = number
  default = 300
}

variable "scale_out_cooldown" {
  type    = number
  default = 300
}

variable "vpc_id" {
  type = string
}

variable "listener_rule_pattern" {
  type = list(string)
}

variable "enable_autoscaling" {
  type    = bool
  default = false
}
