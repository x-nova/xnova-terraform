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

# resource "aws_lb_listener" "selected80" {
#   load_balancer_arn = aws_lb.this.arn
#   port              = "80"
#   protocol          = "HTTP"

#   default_action {
#     type             = "redirect"
#     redirect {
#       protocol        = "HTTPS"
#       port            = "443"
#       host            = var.environment == "production" ? "novawallet.exchange" : var.environment == "staging" ? "staging.novawallet.exchange" : "dev.novawallet.exchange"
#       path            = "/"
#       query           = "redirected=true"
#       status_code     = "HTTP_301"
#     }
#   }
# }

resource "aws_lb_listener" "selected443" {
  load_balancer_arn = aws_lb.this.arn
  port              = "443"
  protocol          = "HTTPS"
  certificate_arn = var.environment == "production" ?  "arn:aws:acm:us-east-1:286458283644:certificate/af54b9ef-05ce-45b5-966f-b48a09ac2b28" : "arn:aws:acm:us-east-1:613930993078:certificate/79c91728-b41c-4913-82cb-4562af083e60"

  default_action {
    type             = "fixed-response"
    fixed_response {
      content_type = "text/plain"
      message_body = "You need to specify a valid route, buddy."
      status_code  = "200"
    }
  }
}

resource "aws_security_group" "lb_sg" {
  name        = "${var.project}-${var.environment}-lb-sg"
  description = "Security group for the load balancer"
  vpc_id      = var.vpc_id

  ingress {
    from_port = 80
    to_port   = 80
    protocol  = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port = 443
    to_port   = 443
    protocol  = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
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
