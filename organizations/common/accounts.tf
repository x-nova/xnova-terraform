resource "aws_organizations_account" "this" {
  depends_on = [
    aws_organizations_organizational_unit.this
  ]
  for_each  = { for organizational_unit_account in var.organizational_unit_accounts : lower("${local.organization_unit_name}-${organizational_unit_account.environment}") => organizational_unit_account }
  name      = each.key
  email     = lookup(each.value, "account_email_override", lower("novawallet+aws-${each.key}@novawallet.exchange"))
  parent_id = aws_organizations_organizational_unit.this.id
}
