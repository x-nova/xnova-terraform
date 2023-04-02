locals {
  domain_name = join(".", compact([var.primary_name, var.domain]))
}
