output "organizational_unit_accounts" {
  value = module.this.member_accounts
}

output "nova_wallet_organizational_unit_id" {
  value = module.this.organizational_unit_id
}

output "nova_wallet_prod_account_id" {
  value = module.this.member_accounts["nova-wallet-production"]
}

output "nova_wallet_nonprod_account_id" {
  value = module.this.member_accounts["nova-wallet-nonprod"]
}
