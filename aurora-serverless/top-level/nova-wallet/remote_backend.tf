terraform {
  backend "s3" {
    bucket         = "xnova-terraform-state"
    key            = "services/ecs-fargate/top-level/waitlist"
    encrypt        = true
    dynamodb_table = "xnova-terraform-lock"
    region         = "us-east-1"
    profile        = "nova"
  }
}
