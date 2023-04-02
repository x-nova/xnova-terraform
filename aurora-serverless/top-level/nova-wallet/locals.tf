locals {
  product     = "nova-wallet"
  component   = "api"
  environment = terraform.workspace
  pg_version  = "13.7"
  aws_profile = {
    production = "nova-wallet-production"
    dev    = "nova-wallet-nonprod"
    staging    = "nova-wallet-nonprod"
  }[terraform.workspace]
  vpc_remote_state_key = {
    dev  = "env:/nonprod/vpcs/nova-wallet"
    staging    = "env:/nonprod/vpcs/nova-wallet"
    production = "env:/production/vpcs/nova-wallet"
  }[terraform.workspace]
}
