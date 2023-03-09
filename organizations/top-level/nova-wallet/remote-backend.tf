terraform {
  backend "s3" {
    bucket         = "xnova-terraform-state"
    key            = "aws-organization/nova-wallet"
    encrypt        = true
    dynamodb_table = "xnova-terraform-lock"
    region         = "us-east-1"
    profile        = "nova"
  }
}
