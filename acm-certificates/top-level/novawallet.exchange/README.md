# Manage the novawallet.co.uk ACM Certificate

## Use case

Manages the novawallet.exchange ACM certificate, and its CloudFront-compatible equivalent

## Workspaces

This module uses separate workspaces for each AWS account:

- production
- nonprod

## Remote state

This module does not need the remote state of any other modules.

## Secret Values

This module does not require a secret `env.auto.tfvars` file, but it does require CloudFlare credentials to be set as environment variables. The required environment variables are:

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

No providers.

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_this"></a> [this](#module\_this) | ../../common/cloudflare | n/a |

## Resources

No resources.

## Inputs

No inputs.

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_acm_certificate_arn"></a> [acm\_certificate\_arn](#output\_acm\_certificate\_arn) | n/a |
| <a name="output_acm_certificate_domain"></a> [acm\_certificate\_domain](#output\_acm\_certificate\_domain) | n/a |
| <a name="output_cloudfront_acm_certificate_arn"></a> [cloudfront\_acm\_certificate\_arn](#output\_cloudfront\_acm\_certificate\_arn) | n/a |
<!-- END_TF_DOCS -->
