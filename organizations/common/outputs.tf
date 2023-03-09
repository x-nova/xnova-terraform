output "organizational_unit_id" {
  description = "The ID of the organizational unit"
  value       = aws_organizations_organizational_unit.this.id
}

output "member_accounts" {
  description = "Account name and IDs of the accounts in the organizational unit"
  value       = { for name, account in aws_organizations_account.this : name => account.id }
}
