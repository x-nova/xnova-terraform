resource "aws_security_group" "ecs_svc_sg" {
  name        = "${var.environment}-${var.project}-${var.project_component}-sg"
  description = "Allow TLS inbound traffic from web to ECS Service"
  vpc_id      = data.aws_vpc.ecs_vpc.id
  depends_on = [
    data.aws_vpc.ecs_vpc
  ]

  ingress {
    description = "TLS from ELB"
    from_port   = var.container_port
    to_port     = var.container_port
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    #    ipv6_cidr_blocks = [aws_vpc.stg_ecs_vpc.ipv6_cidr_block]
  }

  ingress {
    description = "TLS from ELB"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    #    ipv6_cidr_blocks = [aws_vpc.stg_ecs_vpc.ipv6_cidr_block]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = {
    createdby   = var.createdby
    project     = var.project
    Name        = var.project_component
    environment = var.environment
    description = "This task is updated using terraform"
  }
}
