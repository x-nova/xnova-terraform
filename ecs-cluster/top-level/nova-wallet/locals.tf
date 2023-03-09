locals {
  environment = terraform.workspace
  project = "nova-wallet"
  aws_profile = {
    production = "nova-wallet-production"
    staging    = "nova-wallet-nonprod"
    dev = "nova-wallet-nonprod"
  }[terraform.workspace]
  vpc_remote_state_key = {
    staging    = "env:/nonprod/vpcs/nova-wallet"
    dev = "env:/nonprod/vpcs/nova-wallet"
    production = "env:/production/vpcs/nova-wallet"
  }[terraform.workspace]
}