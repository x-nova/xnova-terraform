variable "organization_unit_name_override" {
  description = "Overrides the Product name to be used as the Organizational Unit name"
  type        = string
  default     = ""
}

variable "organizational_unit_accounts" {
  description = "List of accounts to create, defined in a map `[{product: 'product', environment: 'environment'}]`, email values get dynamically generated, account_name_override and account_email_override are optional, and provide overrides for the default account name and email"
  type        = list(map(string))
  default     = []
}

variable "parent_id" {
  description = "Parent ID of the organizational unit, defaults to the `Workloads` organizational unit"
  type        = string
  default     = "ou-67j1-4r1rf2iq"
}

variable "product" {
  description = "Name of the product being hosted in this account"
  type        = string
  default     = ""
}
