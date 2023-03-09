resource "aws_ecs_cluster" "this" {
  name = "${var.project}-${var.environment}-cluster"
}

resource "aws_ecs_cluster_capacity_providers" "this" {
  cluster_name = aws_ecs_cluster.this.name

  capacity_providers = ["FARGATE"]

  default_capacity_provider_strategy {
    base              = 1
    weight            = 100
    capacity_provider = "FARGATE"
  }
}

resource "aws_service_discovery_public_dns_namespace" "this" {
  name        = var.environment == "production" ? "api.novawallet.exchange" : var.environment == "staging" ? "api.stg.novawallet.exchange" : "api.dev.novawallet.exchange"
  description = "Public DNS namespace for the novawallet.exchange domain"
}
