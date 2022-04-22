#############################################################################
##$$                         VPC & SUBNET                                $$##
#############################################################################

data "aws_vpc" "ecs_vpc" {
  id = var.vpc_id
}

##############################################

data "aws_subnet_ids" "ecs_vpc_subnets" {
  vpc_id = var.vpc_id
}

data "aws_subnet" "ecs_subnets" {
  for_each = data.aws_subnet_ids.ecs_vpc_subnets.ids
  id       = each.value
}

#############################################################################
##$$                    ELB && ELB SECURITY GROUP                         $$##
#############################################################################

data "aws_lb" "ecs_lb" {
  arn  = var.elb_arn
  name = "${var.environment}-${var.project}-lb"
}

resource "aws_lb_target_group" "ecs_tg" {
  name        = "${var.environment}-${var.project}-${var.project_component}-tg"
  port        = 8081
  protocol    = "HTTP"
  target_type = "ip"
  slow_start  = 60
  vpc_id      = data.aws_vpc.ecs_vpc.id
  health_check {
    enabled             = var.health_check
    path                = var.health_check_path
    timeout             = 60
    interval            = 120
    unhealthy_threshold = 5
  }
}

resource "aws_lb_listener" "selected8081" {
  load_balancer_arn = data.aws_lb.ecs_lb.arn
  port              = 8081
}

resource "aws_lb_listener_rule" "listener_rule_http" {
  listener_arn = aws_lb_listener.selected80.arn
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
