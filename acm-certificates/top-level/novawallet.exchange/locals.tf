locals {
  create_cloudfront_certificate = {
    production                        = true
    nonprod                    = true
  }[terraform.workspace]
  aws_profile = {
    production = "nova-wallet-production"
    nonprod    = "nova-wallet-nonprod"
  }[terraform.workspace]
}
