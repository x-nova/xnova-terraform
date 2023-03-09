locals {
  repositories = {
    "nova-wallet-waitlist-api" = []
  }

  environment = terraform.workspace
  project = "nova-wallet"
  components = [
    "waitlist-api"
  ]
  aws_profile = {
    production = "nova-wallet-production"
    staging    = "nova-wallet-nonprod"
    dev = "nova-wallet-nonprod"
  }[terraform.workspace]
}
