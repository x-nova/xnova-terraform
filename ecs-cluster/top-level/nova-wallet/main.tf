module "cluster" {
  source = "../../common"
  environment = local.environment
  project = local.project
  vpc_id = data.terraform_remote_state.network_vpc.outputs.nova-wallet.vpc.vpc_id
  public_subnets          = data.terraform_remote_state.network_vpc.outputs.nova-wallet.vpc.public_subnets
}