locals {
  product     = "nova-wallet"
  component   = "api"
  environment = terraform.workspace
  pg_version  = "13.7"
  aws_profile = {
    production = "nova-wallet-production"
    nonprod    = "nova-wallet-nonprod"
  }[terraform.workspace]
  vpc_remote_state_key = {
    temporary  = "env:/nonprod/vpcs/nova-wallet"
    staging    = "env:/nonprod/vpcs/nova-wallet"
    production = "env:/production/vpcs/nova-wallet"
  }[terraform.workspace]
}
