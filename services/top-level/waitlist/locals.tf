locals {
  project     = "nova-wallet"
  component   = "waitlist-api"
  full_name = "${local.project}-${local.component}-${local.environment}"
  environment = terraform.workspace
  aws_profile = {
    production = "nova-wallet-production"
    staging    = "nova-wallet-nonprod"
    dev = "nova-wallet-nonprod"
  }[terraform.workspace]
  vpc_remote_state_key = {
    dev  = "env:/nonprod/vpcs/nova-wallet"
    staging    = "env:/nonprod/vpcs/nova-wallet"
    production = "env:/production/vpcs/nova-wallet"
  }[terraform.workspace]
  environment_variables = {
    dev = {
    "DB_CONNECTION" = "postgres"
    "DB_HOST" = "nova-wallet-api-database-dev20230318111123941600000001.cluster-clo8quthxlxa.us-east-1.rds.amazonaws.com"
    "DB_PORT" = "5432"
    "DB_DATABASE" = "novawallet"
    "DB_USERNAME" = "hvkpjrfk"
    "DB_PASSWORD" = "{(a#Nj<&31mJRLA-C&VYLXenCW^KzBM0s_9+(M8D"
  }
    staging = {
    "DB_CONNECTION" = "pgsql"
    "DB_HOST" = "nova-wallet-api-database-staging20230318111123941600000001.cluster-clo8quthxlxa.us-east-1.rds.amazonaws.com"
    "DB_PORT" = "5432"
    "DB_DATABASE" = "novawallet"
    "DB_USERNAME" = "hvkpjrfk"
    "DB_PASSWORD" = "{(a#Nj<&31mJRLA-C&VYLXenCW^KzBM0s_9+(M8D"
  }
    production = {
    "DB_CONNECTION" = "postgres"
    "DB_HOST" = "nova-wallet-api-database-production20230318111123941600000001.cluster-clo8quthxlxa.us-east-1.rds.amazonaws.com"
    "DB_PORT" = "5432"
    "DB_DATABASE" = "novawallet"
    "DB_USERNAME" = "hvkpjrfk"
    "DB_PASSWORD" = "{(a#Nj<&31mJRLA-C&VYLXenCW^KzBM0s_9+(M8D"
  }
}[terraform.workspace]
}