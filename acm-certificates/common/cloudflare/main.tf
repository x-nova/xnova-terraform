resource "aws_acm_certificate" "this" {
  domain_name       = local.domain_name
  validation_method = "DNS"
  tags = {
    "nova-wallet:domain" = var.domain
  }
}

resource "aws_acm_certificate" "cloudfront" {
  count    = var.create_cloudfront_certificate ? 1 : 0
  provider = aws.cloudfront

  domain_name       = local.domain_name
  validation_method = "DNS"
  tags = {
    "nova-wallet:domain" = var.domain
  }
}

resource "aws_acm_certificate_validation" "this" {
  certificate_arn = aws_acm_certificate.this.arn
  validation_record_fqdns = [
    for record in aws_acm_certificate.this.domain_validation_options : record.resource_record_name
  ]
}

resource "cloudflare_record" "acm_validated_cname" {
  for_each = { for domain_validation_object in aws_acm_certificate.this.domain_validation_options :
    domain_validation_object.domain_name => {
      name   = domain_validation_object.resource_record_name
      record = domain_validation_object.resource_record_value
      type   = domain_validation_object.resource_record_type
    }
  }

  name    = each.value.name
  type    = each.value.type
  zone_id = data.cloudflare_zones.novawallet_zones.zones[0].id
  value   = trimsuffix(each.value.record, ".")
  ttl     = 1
  proxied = false
}
