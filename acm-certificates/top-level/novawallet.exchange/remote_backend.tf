terraform {
  backend "s3" {
    bucket         = "xnova-terraform-state"
    key            = "acm-certificates/top-level/novawallet.exchange"
    encrypt        = true
    dynamodb_table = "xnova-terraform-lock"
    region         = "us-east-1"
    profile        = "nova"
  }
}
