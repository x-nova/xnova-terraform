module "ecr-repository" {
    source = "../../common/ecr-repositories"
    project     = local.project
    component   = local.component
    environment = local.environment
}

module "ecs-fargate" {
    source  = "../../common/ecs"
    project     = local.project
    component   = local.component
    environment = local.environment
    vpc_id = data.terraform_remote_state.network_vpc.outputs.nova-wallet.vpc.vpc_id
    ecs_subnets          = data.terraform_remote_state.network_vpc.outputs.nova-wallet.vpc.private_subnets
    listener_rule_pattern = ["/api/waitlist*"]
    enable_autoscaling = local.environment == "production" ? true : false
    health_check_path = "/api/waitlist/health"
    environment_variables = local.environment_variables
}

# module "pipeline" {
#     depends_on = [
#       module.ecr-repository,
#       module.ecs-fargate
#     ]
#     source = "../../common/pipelines"
#     project     = local.project
#     component   = local.component
#     environment = local.environment
#     code_repo = "https://github.com/x-nova/waitlist-api.git"
#     tech = "php"
#     ecr_repository_url = module.ecr-repository.repository_uri
# }