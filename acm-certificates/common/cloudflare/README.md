# ACM Certificates

## Use case

Creates ACM certificates for domains that manage their DNS settings in CloudFlare.
Optionally, it creates an ACM certificate to enable SSL/TLS for CLoudFront.

## Usage example

```terraform
module "this" {
  source = "../../../common/cloudflare"
  domain = "novawallet-test.co.uk"
}
```

## Secret values

Top level modules that call this module require CloudFlare environment variables. The required environment variables are:

- CLOUDFLARE_API_KEY
- CLOUDFLARE_EMAIL

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | ~> 1.0 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | ~> 4.0 |
| <a name="requirement_cloudflare"></a> [cloudflare](#requirement\_cloudflare) | ~> 3.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | ~> 4.0 |
| <a name="provider_aws.cloudfront"></a> [aws.cloudfront](#provider\_aws.cloudfront) | ~> 4.0 |
| <a name="provider_cloudflare"></a> [cloudflare](#provider\_cloudflare) | ~> 3.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_acm_certificate.cloudfront](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/acm_certificate) | resource |
| [aws_acm_certificate.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/acm_certificate) | resource |
| [aws_acm_certificate_validation.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/acm_certificate_validation) | resource |
| [cloudflare_record.acm_validated_cname](https://registry.terraform.io/providers/cloudflare/cloudflare/latest/docs/resources/record) | resource |
| [cloudflare_zones.novawallet_zones](https://registry.terraform.io/providers/cloudflare/cloudflare/latest/docs/data-sources/zones) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_aws_profile"></a> [aws\_profile](#input\_aws\_profile) | Name of the AWS profile to be used. This should match with the AWS account to be used. Check the [naming convention](https://novawallet.atlassian.net/l/c/UjgA11Tq) | `string` | `"novawallet"` | no |
| <a name="input_create_cloudfront_certificate"></a> [create\_cloudfront\_certificate](#input\_create\_cloudfront\_certificate) | Whether to create a certificate for SSL/TLS CloudFront, this is required to be in `us-1-east` | `bool` | `false` | no |
| <a name="input_domain"></a> [domain](#input\_domain) | Domain covered by this certificate | `string` | n/a | yes |
| <a name="input_primary_name"></a> [primary\_name](#input\_primary\_name) | Subdomains covered by this certificate | `string` | `"*"` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_acm_certificate_arn"></a> [acm\_certificate\_arn](#output\_acm\_certificate\_arn) | ARN of the certificate |
| <a name="output_acm_certificate_domain"></a> [acm\_certificate\_domain](#output\_acm\_certificate\_domain) | Domain covered by this certificate |
| <a name="output_cloudfront_acm_certificate_arn"></a> [cloudfront\_acm\_certificate\_arn](#output\_cloudfront\_acm\_certificate\_arn) | ARN of the certificate for CloudFront |
| <a name="output_validation_cnames"></a> [validation\_cnames](#output\_validation\_cnames) | CNAMEs used to validate this record. This output is blank if this module didn't create the validation records |
<!-- END_TF_DOCS -->
