module "this" {
  source = "../../common/cloudflare"

  domain = "novawallet.exchange"

  aws_profile                   = local.aws_profile
  create_cloudfront_certificate = local.create_cloudfront_certificate
}
