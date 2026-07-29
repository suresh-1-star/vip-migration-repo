terraform {
  required_version = ">= 1.5.0"

  backend "s3" {
    bucket         = "vip-migration-tfstate-production"
    key            = "app1-ecs-backend/production/terraform.tfstate"
    region         = "us-east-1"
    dynamodb_table = "vip-migration-tfstate-lock"
    encrypt        = true
  }
}