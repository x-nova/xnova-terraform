variable "vpc_id" {
  default = "vpc-e01e9e85"
}

variable "vpc_subnet1" {
  default = "subnet-24d14341"
}

variable "vpc_subnet2" {
  default = "subnet-5d5f9f04"
}

variable "vpc_subnet3" {
  default = "subnet-bb68c9cc"
}

variable "vpc_subnet4" {
  default = "subnet-e09b04ec"
}

variable "vpc_subnet5" {
  default = "subnet-e17d17db"
}

variable "vpc_subnet6" {
  default = "subnet-e17d17db"
}

variable "ecs_subnets" {
  default = ["subnet-24d14341", "subnet-5d5f9f04", "subnet-bb68c9cc", "subnet-e09b04ec", "subnet-e17d17db", "subnet-e17d17db"]
}
