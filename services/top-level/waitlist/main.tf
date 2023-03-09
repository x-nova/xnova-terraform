module "ecs-fargate" {
    source  = "../../common/ecs"
    project     = local.project
    component   = local.component
    environment = local.environment
    vpc_id = data.terraform_remote_state.network_vpc.outputs.nova-wallet.vpc.vpc_id
    ecs_subnets          = data.terraform_remote_state.network_vpc.outputs.nova-wallet.vpc.private_subnets
    listener_rule_pattern = ["/*"]
}

module "pipeline" {
    source = "../../common/pipelines"
    project     = local.project
    component   = local.component
    environment = local.environment
    code_repo = "https://github.com/xnova/waitlist-api.git"
    tech = "java"
}