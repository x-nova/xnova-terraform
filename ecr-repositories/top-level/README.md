# Manage ECR Repositories

## Use case

Manage ECR repositories and their lifecycle rules.

## Resources created

This module creates ECR repositories for our docker images, and lifecycle rules to delete outdated images.

## Common modules used

This module uses the [ecr-repositories/common/](../common) module.

## Workspaces

No workspaces are used in this module.

## Remote state

This module does not use any remote state.

## Secret Values

This module does not require a secret `env.auto.tfvars` file.

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | ~> 4.0 |

## Providers

No providers.

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_this"></a> [this](#module\_this) | ../common | n/a |

## Resources

No resources.

## Inputs

No inputs.

## Outputs

No outputs.
<!-- END_TF_DOCS -->
