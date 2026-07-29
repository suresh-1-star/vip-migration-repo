# ==============================================================================
# VPC OUTPUTS
# ==============================================================================

output "vpc_id" {
  description = "The ID of the staging VPC"
  value       = module.vpc.vpc_id
}

output "public_subnet_ids" {
  description = "List of public subnet IDs in staging"
  value       = module.vpc.public_subnet_ids
}

output "private_subnet_ids" {
  description = "List of private subnet IDs in staging"
  value       = module.vpc.private_subnet_ids
}

# ==============================================================================
# ALB & TARGET GROUP OUTPUTS
# ==============================================================================

output "alb_arn" {
  description = "The ARN of the Application Load Balancer"
  value       = module.alb.alb_arn
}

output "alb_dns_name" {
  description = "The DNS name of the ALB"
  value       = module.alb.alb_dns_name
}

output "target_group_arn" {
  description = "The ARN of the ECS Target Group (TSK-301 Compliant)"
  value       = module.target_group.target_group_arn
}

# ==============================================================================
# ROUTE 53 CANARY OUTPUTS (TSK-202)
# ==============================================================================

output "route53_fqdn" {
  description = "The Fully Qualified Domain Name of the Route 53 canary record"
  value       = module.route53.record_fqdn
}