# data "external" "tags_of_most_recently_pushed_image" {
#   program = ["bash", "-c", <<-EOT
#     aws ecr describe-images \
#       --repository-name ${var.project}-${var.component}-${var.environment} \
#       --query 'sort_by(imageDetails,& imagePushedAt)[-1].imageTags' \
#       --output json
#   EOT
#   ]
# }

data "aws_subnet_ids" "ecs_vpc_subnets" {
  vpc_id = var.vpc_id
}

data "aws_subnet" "ecs_subnets" {
  for_each = data.aws_subnet_ids.ecs_vpc_subnets.ids
  id       = each.value
}

data "aws_lb" "ecs_lb" {
  name = "${var.project}-${var.environment}-lb"
}

data "aws_lb_listener" "selected443" {
  load_balancer_arn = data.aws_lb.ecs_lb.arn
  port              = 443
}

data "aws_lb_listener" "selected80" {
  load_balancer_arn = data.aws_lb.ecs_lb.arn
  port              = 80
}
