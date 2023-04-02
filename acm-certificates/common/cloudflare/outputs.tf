output "acm_certificate_arn" {
  description = "ARN of the certificate"
  value       = aws_acm_certificate.this.arn
}

output "cloudfront_acm_certificate_arn" {
  description = "ARN of the certificate for CloudFront"
  value       = var.create_cloudfront_certificate ? aws_acm_certificate.cloudfront[0].arn : null
}

output "acm_certificate_domain" {
  description = "Domain covered by this certificate"
  value       = aws_acm_certificate.this.domain_name
}

output "validation_cnames" {
  description = "CNAMEs used to validate this record. This output is blank if this module didn't create the validation records"
  value       = [for record in cloudflare_record.acm_validated_cname : record.hostname]
}
