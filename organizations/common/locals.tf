locals {
  organization_unit_name = (var.organization_unit_name_override == "" ? var.product : var.organization_unit_name_override)
}
