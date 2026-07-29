# ------------------------------------------------------------------------------
# REGION & NETWORK CONFIGURATION
# ------------------------------------------------------------------------------
aws_region           = "eu-west-1" # TSK-401 Audit location
vpc_cidr             = "10.10.0.0/16"
public_subnet_cidrs  = ["10.10.1.0/24", "10.10.2.0/24"]
private_subnet_cidrs = ["10.10.101.0/24", "10.10.102.0/24"]

# ------------------------------------------------------------------------------
# ALB & TARGET GROUP CONFIGURATION
# ------------------------------------------------------------------------------
alb_internal           = false
alb_security_group_ids = ["sg-0123456789abcdef0"]
target_group_name      = "tg-ecs-backend-v1-staging"
health_check_path      = "/health" # TSK-301.1 Audit Standard

# ------------------------------------------------------------------------------
# SSL / TLS CONFIGURATION (TSK-401 AUDIT COMPLIANCE)
# ------------------------------------------------------------------------------
certificate_arn = "arn:aws:acm:eu-west-1:123456789012:certificate/abc12345-6789-0123-4567-89abcdef0123"

# ------------------------------------------------------------------------------
# ECS COMPUTE CONFIGURATION
# ------------------------------------------------------------------------------
container_image    = "123456789012.dkr.ecr.eu-west-1.amazonaws.com/ecs-backend:v1.0"
container_port     = 8080
execution_role_arn = "arn:aws:iam::123456789012:role/ecsExecutionRole"
task_role_arn      = "arn:aws:iam::123456789012:role/ecsTaskRole"

# ------------------------------------------------------------------------------
# ROUTE 53 & HYBRID DNS CONFIGURATION (TSK-201)
# ------------------------------------------------------------------------------
domain_name = "emea.fedex.com" # Creates PHZ & manages CNAME aliases (ecs, ecs-nos, ecs-dub)

# ------------------------------------------------------------------------------
# COMMON TAGS
# ------------------------------------------------------------------------------
tags = {
  Environment = "staging"
  Project     = "vip-migration"
  Application = "ecs-backend"
  ManagedBy   = "Terraform"
}