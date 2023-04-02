variable "aws_profile" {
  type        = string
  description = "Name of the AWS profile to be used. This should match with the AWS account to be used. Check the [naming convention](https://novawallet.atlassian.net/l/c/UjgA11Tq)"
  default     = "novawallet"
}

variable "domain" {
  type        = string
  description = "Domain covered by this certificate"
}

variable "primary_name" {
  type        = string
  description = "Subdomains covered by this certificate"
  default     = "*"
}

variable "create_cloudfront_certificate" {
  type        = bool
  description = "Whether to create a certificate for SSL/TLS CloudFront, this is required to be in `us-1-east`"
  default     = false
}
