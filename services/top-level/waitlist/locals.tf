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
}
