# ------------------------------------------------------------------------------
# REGION & NETWORK CONFIGURATION
# ------------------------------------------------------------------------------
variable "aws_region" {
  description = "AWS region for deployment"
  type        = string
  default     = "eu-west-1" # Aligned with TSK-401 audit specification
}

variable "vpc_cidr" {
  description = "CIDR block for the VPC"
  type        = string
}

variable "public_subnet_cidrs" {
  description = "List of public subnet CIDRs"
  type        = list(string)
}

variable "private_subnet_cidrs" {
  description = "List of private subnet CIDRs"
  type        = list(string)
}

variable "availability_zones" {
  type        = list(string)
  description = "List of AWS availability zones"
  default     = ["us-east-1a", "us-east-1b"]
}

# ------------------------------------------------------------------------------
# ALB & TARGET GROUP CONFIGURATION
# ------------------------------------------------------------------------------
variable "alb_internal" {
  description = "Boolean flag to set internal or internet-facing load balancer"
  type        = bool
  default     = false
}

variable "alb_security_group_ids" {
  description = "Security group IDs for ALB"
  type        = list(string)
}

variable "ecs_security_group_id" {
  description = "Security group ID attached to ECS tasks"
  type        = string
}

variable "target_group_name" {
  description = "Name of the target group (e.g., tg-ecs-backend-v1-staging)"
  type        = string
  default     = "tg-ecs-backend-v1-staging"
}

variable "health_check_path" {
  description = "TSK-301.1: Health check URI path on application target"
  type        = string
  default     = "/health"
}

# ------------------------------------------------------------------------------
# SSL / TLS CONFIGURATION (TSK-401 AUDIT COMPLIANCE)
# ------------------------------------------------------------------------------
variable "certificate_arn" {
  description = "TSK-401: ACM Certificate ARN for ecs.emea.fedex.com attached to HTTPS listener"
  type        = string
}

variable "route53_target" {
  description = "Route53 target value for the record set"
  type        = string
}

# ------------------------------------------------------------------------------
# ECS COMPUTE CONFIGURATION
# ------------------------------------------------------------------------------
variable "container_image" {
  description = "Container image for ECS"
  type        = string
}

variable "container_port" {
  description = "Container port"
  type        = number
  default     = 8080
}

variable "execution_role_arn" {
  description = "Execution role ARN for ECS tasks"
  type        = string
}

variable "task_role_arn" {
  description = "Task role ARN for ECS tasks"
  type        = string
}

# ------------------------------------------------------------------------------
# ROUTE 53 & CANARY ROUTING CONFIGURATION (TSK-202)
# ------------------------------------------------------------------------------
variable "route53_zone_id" {
  description = "Route53 hosted zone ID"
  type        = string
}

variable "route53_record_name" {
  description = "TSK-202.1: Route53 record name (e.g., ecs.gtm.emea.fedex.com)"
  type        = string
  default     = "ecs.gtm.emea.fedex.com"
}

variable "canary_weight" {
  description = "TSK-202.2/202.5: Route 53 canary routing weight for AWS ALB target (0-100)"
  type        = number
  default     = 20 # 20% AWS Canary / 80% On-Prem
}

# ------------------------------------------------------------------------------
# COMMON TAGS
# ------------------------------------------------------------------------------
variable "tags" {
  description = "Common tags applied across resources"
  type        = map(string)
  default     = {}
}