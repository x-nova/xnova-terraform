module "this" {
  source  = "../../common"
  product = "nova-wallet"
  organizational_unit_accounts = [
    {
      environment = "production"
    },
    {
      environment = "nonprod"
    },
  ]
}
