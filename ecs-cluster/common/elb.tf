resource "aws_lb" "this" {
  name               = "${var.project}-${var.environment}-lb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.lb_sg.id]
  subnets            = var.public_subnets

  enable_deletion_protection = true

  tags = {
    Environment = var.environment
    Project = var.project
  }
}

resource "aws_security_group" "lb_sg" {
  name        = "${var.project}-${var.environment}-lb-sg"
  description = "Security group for the load balancer"
  vpc_id      = var.vpc_id

  tags = {
    Environment = var.environment
    Project = var.project
  }
}

resource "aws_s3_bucket" "lb_logs" {
  bucket = "${var.project}-${var.environment}-lb-logs"

  tags = {
    Environment = var.environment
    Project = var.project
  }
}
