output "vpc_id" {
  value = module.vpc.vpc_id
}

output "public_subnet_ids" {
  value = module.vpc.public_subnet_ids
}

output "private_subnet_ids" {
  value = module.vpc.private_subnet_ids
}

output "alb_arn" {
  value = module.alb.alb_arn
}

output "target_group_arn" {
  description = "ARN of the target group"
  value       = module.target_group.target_group_arn
}

output "route53_fqdn" {
  value = module.route53.record_fqdn
}
