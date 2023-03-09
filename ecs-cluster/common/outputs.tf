output "ecs_cluster_name" {
  value = aws_ecs_cluster.this.name
}

output "load_balancer_arn" {
  value = aws_lb.this.arn
}

output "load_balancer_dns_name" {
  value = aws_lb.this.dns_name
}

output "load_balancer_zone_id" {
  value = aws_lb.this.zone_id
}

output "load_balancer_security_group_id" {
  value = aws_security_group.lb_sg.id
}

output "load_balancer_security_group_name" {
  value = aws_security_group.lb_sg.name
}

output "load_balancer_security_group_arn" {
  value = aws_security_group.lb_sg.arn
}

output "load_balancer_security_group_description" {
  value = aws_security_group.lb_sg.description
}

output "load_balancer_security_group_vpc_id" {
  value = aws_security_group.lb_sg.vpc_id
}

output "load_balancer_security_group_owner_id" {
  value = aws_security_group.lb_sg.owner_id
}

output "load_balancer_security_group_ingress" {
  value = aws_security_group.lb_sg.ingress
}

output "load_balancer_security_group_egress" {
  value = aws_security_group.lb_sg.egress
}
