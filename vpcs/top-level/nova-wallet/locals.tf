locals {
  environment = terraform.workspace
  aws_profile = {
    production = "nova-wallet-production"
    nonprod    = "nova-wallet-nonprod"
  }[terraform.workspace]
}
