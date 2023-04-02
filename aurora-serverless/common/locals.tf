locals {
  full_name = "${var.product}-${var.component}-database-${var.environment}"

  tags = {
    "novawallet:application-role" = "database"
    "novawallet:tier"             = "infrastructure"
    "novawallet:product"          = var.product
    "novawallet:environment"      = var.environment
  }
  engine_name = "aurora-postgresql"
  pg_version  = var.pg_version
  pg_family   = "${local.engine_name}${trimsuffix(local.pg_version, regex("[.][0-9]+$", local.pg_version))}"
  selected_azs = slice(
    data.aws_availability_zones.primary_azs.names,
    0,
    3
  )
}
