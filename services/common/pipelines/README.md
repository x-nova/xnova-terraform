<!-- BEGIN_TF_DOCS -->
## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | n/a |
| <a name="provider_external"></a> [external](#provider\_external) | n/a |
| <a name="provider_template"></a> [template](#provider\_template) | n/a |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_codebuild_project.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/codebuild_project) | resource |
| [aws_codepipeline.ecs_codepipeline_project](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/codepipeline) | resource |
| [aws_ecr_repository.ecs](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ecr_repository) | resource |
| [aws_iam_role.ecs_codebuild](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role) | resource |
| [aws_iam_role.ecs_codepipeline](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role) | resource |
| [aws_iam_role_policy.codepipeline_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy) | resource |
| [aws_iam_role_policy.ecs-role-policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy) | resource |
| [aws_codestarconnections_connection.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/codestarconnections_connection) | data source |
| [external_external.tags_of_most_recently_pushed_image](https://registry.terraform.io/providers/hashicorp/external/latest/docs/data-sources/external) | data source |
| [template_file.buildspec](https://registry.terraform.io/providers/hashicorp/template/latest/docs/data-sources/file) | data source |
| [template_file.codebuild_role](https://registry.terraform.io/providers/hashicorp/template/latest/docs/data-sources/file) | data source |
| [template_file.codebuild_role_policy](https://registry.terraform.io/providers/hashicorp/template/latest/docs/data-sources/file) | data source |
| [template_file.codepipeline_role](https://registry.terraform.io/providers/hashicorp/template/latest/docs/data-sources/file) | data source |
| [template_file.codepipeline_role_policy](https://registry.terraform.io/providers/hashicorp/template/latest/docs/data-sources/file) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_buildspec_java"></a> [buildspec\_java](#input\_buildspec\_java) | n/a | `string` | `"scripts/buildspec-java.yaml"` | no |
| <a name="input_buildspec_node"></a> [buildspec\_node](#input\_buildspec\_node) | n/a | `string` | `"scripts/buildspec-node.yaml"` | no |
| <a name="input_code_repo"></a> [code\_repo](#input\_code\_repo) | n/a | `string` | n/a | yes |
| <a name="input_codebuild_role"></a> [codebuild\_role](#input\_codebuild\_role) | n/a | `string` | `"scripts/codebuild_role.json"` | no |
| <a name="input_codebuild_role_policy"></a> [codebuild\_role\_policy](#input\_codebuild\_role\_policy) | n/a | `string` | `"scripts/codebuild_role_policy.json"` | no |
| <a name="input_codepipeline_role"></a> [codepipeline\_role](#input\_codepipeline\_role) | n/a | `string` | `"scripts/codepipeline_role.json"` | no |
| <a name="input_codepipeline_role_policy"></a> [codepipeline\_role\_policy](#input\_codepipeline\_role\_policy) | n/a | `string` | `"scripts/codepipeline_role_policy.json"` | no |
| <a name="input_ecs_cluster_name"></a> [ecs\_cluster\_name](#input\_ecs\_cluster\_name) | n/a | `string` | n/a | yes |
| <a name="input_ecs_service_name"></a> [ecs\_service\_name](#input\_ecs\_service\_name) | n/a | `string` | n/a | yes |
| <a name="input_repo_branch"></a> [repo\_branch](#input\_repo\_branch) | n/a | `string` | n/a | yes |
| <a name="input_repo_id"></a> [repo\_id](#input\_repo\_id) | n/a | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_repository_uri"></a> [repository\_uri](#output\_repository\_uri) | n/a |
<!-- END_TF_DOCS -->