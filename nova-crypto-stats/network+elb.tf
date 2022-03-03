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
#  name = "${var.environment}-${var.project}-lb"
}

resource "aws_lb_target_group" "ecs_tg" {
  name        = "${var.environment}-${var.project}-${var.project_component}-tg"
  port        = "80"
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

resource "aws_lb_listener" "service_port_listener" {
  load_balancer_arn = data.aws_lb.ecs_lb.arn
  port              = var.container_port
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.ecs_tg.arn
  }
}
