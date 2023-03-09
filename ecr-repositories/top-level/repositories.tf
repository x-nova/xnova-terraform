module "this" {
  count = length(local.components)
  source   = "../common"

  repository_name   = "${local.project}-${local.components[count.index]}-${local.environment}"
}

