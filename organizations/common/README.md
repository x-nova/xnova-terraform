# AWS Organizations

## Use case

Creates an AWS Organizational Unit and its AWS accounts.

## Usage example

```
module "aws-organization-accounts" {
  source                       = "../../common"
  product = "Railsafe"
  organizational_unit_accounts = [
    {
      environment            = "production"
    },
    {
      environment = "staging"
      account_name_override = "devops+staging@novawallet.co.uk"
    },
  ]
}
```


<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | ~> 4.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | ~> 4.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_organizations_account.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/organizations_account) | resource |
| [aws_organizations_organizational_unit.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/organizations_organizational_unit) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_organization_unit_name_override"></a> [organization\_unit\_name\_override](#input\_organization\_unit\_name\_override) | Overrides the Product name to be used as the Organizational Unit name | `string` | `""` | no |
| <a name="input_organizational_unit_accounts"></a> [organizational\_unit\_accounts](#input\_organizational\_unit\_accounts) | List of accounts to create, defined in a map `[{product: 'product', environment: 'environment'}]`, email values get dynamically generated, account\_name\_override and account\_email\_override are optional, and provide overrides for the default account name and email | `list(map(string))` | `[]` | no |
| <a name="input_parent_id"></a> [parent\_id](#input\_parent\_id) | Parent ID of the organizational unit, defaults to the `Workloads` organizational unit | `string` | `"ou-4zgj-95yanjci"` | no |
| <a name="input_product"></a> [product](#input\_product) | Name of the product being hosted in this account | `string` | `""` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_member_accounts"></a> [member\_accounts](#output\_member\_accounts) | Account name and IDs of the accounts in the organizational unit |
| <a name="output_organizational_unit_id"></a> [organizational\_unit\_id](#output\_organizational\_unit\_id) | The ID of the organizational unit |
<!-- END_TF_DOCS -->