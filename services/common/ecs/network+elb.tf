resource "aws_lb_target_group" "ecs_tg" {
  name        = "${var.project}-${var.component}-${var.environment}-tg"
  port        = var.container_port
  protocol    = "HTTP"
  target_type = "ip"
  slow_start  = 60
  vpc_id      = var.vpc_id
  health_check {
    enabled             = var.health_check
    path                = var.health_check_path
    timeout             = var.health_check_grace_period_seconds
    interval            = var.health_check_ping_interval
    unhealthy_threshold = var.unhealthy_threshold
  }
}

resource "aws_lb_listener_rule" "listener_rule_https" {
  listener_arn = data.aws_lb_listener.selected443.arn
  #priority     = 100

  action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.ecs_tg.arn
  }

  condition {
    path_pattern {
      values = var.listener_rule_pattern
    }
  }
}

resource "aws_security_group" "ecs_svc_sg" {
  name        = "${var.project}-${var.component}-${var.environment}-sg"
  description = "Allow TLS inbound traffic from web to ECS Service"
  vpc_id      = var.vpc_id

  ingress {
    description = "TLS from ELB"
    from_port   = var.container_port
    to_port     = var.container_port
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "TLS from ELB"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = {
    project     = var.project
    Name        = var.component
    environment = var.environment
    description = "This task is updated using terraform"
  }
}