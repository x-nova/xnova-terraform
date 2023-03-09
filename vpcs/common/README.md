# AWS VPC

## Use case

This common module creates a VPC in AWS with:

- 3 private subnets
- 3 public subnets
- 3 database subnets
- (optional) 3 elasticache subnets

## Usage example

```
module "test_vpc" {
  source = "../common"
    name = "test-vpc"
}
```

<!-- BEGIN_TF_DOCS -->
## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | n/a |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_vpc"></a> [vpc](#module\_vpc) | terraform-aws-modules/vpc/aws | 3.18.1 |

## Resources

| Name | Type |
|------|------|
| [aws_availability_zones.available](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/availability_zones) | data source |
| [aws_region.current](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/region) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_cluster_name"></a> [cluster\_name](#input\_cluster\_name) | Name of the EKS cluster. If blank, the cluster's name is assumed to be the VPCs name | `string` | `""` | no |
| <a name="input_create_elasticache_subnets"></a> [create\_elasticache\_subnets](#input\_create\_elasticache\_subnets) | Create Elasticache subnets | `bool` | `false` | no |
| <a name="input_enable_flow_log"></a> [enable\_flow\_log](#input\_enable\_flow\_log) | Enable VPC flow logs | `bool` | `true` | no |
| <a name="input_name"></a> [name](#input\_name) | Name of the VPC (e.g. `pa`, `railsafe`) | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_vpc"></a> [vpc](#output\_vpc) | Output of the open source [AWS VPC Terraform module](https://registry.terraform.io/modules/terraform-aws-modules/vpc/aws/3.14.0?tab=outputs) |
<!-- END_TF_DOCS -->
