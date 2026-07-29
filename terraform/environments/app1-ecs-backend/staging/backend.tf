terraform {
  required_version = ">= 1.5.0"

  backend "s3" {
    bucket         = "vip-migration-tfstate-staging"
    key            = "app1-ecs-backend/staging/terraform.tfstate"
    region         = "us-east-1"
    dynamodb_table = "vip-migration-tfstate-lock"
    encrypt        = true
  }
}