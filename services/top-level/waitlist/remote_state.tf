data "terraform_remote_state" "network_vpc" {
  backend = "s3"

  config = {
    bucket  = "xnova-terraform-state"
    key     = local.vpc_remote_state_key
    region  = "us-east-1"
    profile = "nova"
  }
}
