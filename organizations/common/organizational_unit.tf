resource "aws_organizations_organizational_unit" "this" {
  name      = local.organization_unit_name
  parent_id = var.parent_id
}
