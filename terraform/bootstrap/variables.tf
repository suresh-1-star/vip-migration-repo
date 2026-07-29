variable "aws_region" {
  description = "AWS region for bootstrap resources"
  type        = string
  default     = "us-east-1"
}

variable "environment" {
  description = "Environment name"
  type        = string
  default     = "shared"
}

variable "state_bucket_name" {
  description = "Name of the S3 bucket used for Terraform remote state"
  type        = string
}

variable "lock_table_name" {
  description = "Name of the DynamoDB table used for Terraform locking"
  type        = string
}
