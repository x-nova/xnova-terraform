terraform {
  backend "s3" {
    bucket         = "xnova-terraform-state"
    key            = "ecr-repositories/nova-wallet"
    encrypt        = true
    dynamodb_table = "xnova-terraform-lock"
    region         = "us-east-1"
    profile        = "nova"
  }
}
