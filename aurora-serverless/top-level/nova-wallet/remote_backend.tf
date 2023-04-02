terraform {
  backend "s3" {
    bucket         = "xnova-terraform-state"
    key            = "services/aurora-serverless/top-level/nova-wallet"
    encrypt        = true
    dynamodb_table = "xnova-terraform-lock"
    region         = "us-east-1"
    profile        = "nova"
  }
}
