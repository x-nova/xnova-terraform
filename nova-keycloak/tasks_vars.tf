variable "loggroup_name" {
  default = "/ecs/verified-inibss-mock"
}

variable "task_cpu" {
  default = "256"
}

variable "task_memory" {
  default = "512"
}

variable "task_family" {
  default = "dev-verified-nibss-mock-tsk"
}

variable "container_definitions" {
  default = "scripts/container_definitions.json"
}

variable "container_port" {
  default = 8116
}
