module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "3.18.1"

  name = var.name
  cidr = local.vpc_cidr_block

  enable_dns_hostnames = true
  enable_dns_support   = true

  azs                 = data.aws_availability_zones.available.names
  private_subnets     = local.subnets.private
  public_subnets      = local.subnets.public
  database_subnets    = local.subnets.database
  elasticache_subnets = var.create_elasticache_subnets ? local.subnets.elasticache : []

  enable_nat_gateway = true

  tags                = local.k8s_tags
  private_subnet_tags = local.private_subnet_tags
  public_subnet_tags  = local.public_subnet_tags

  enable_flow_log                           = var.enable_flow_log
  flow_log_cloudwatch_log_group_name_prefix = var.name
  create_flow_log_cloudwatch_iam_role       = var.enable_flow_log
  create_flow_log_cloudwatch_log_group      = var.enable_flow_log
}
