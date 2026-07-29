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
  value = module.target_group.arn
}

output "route53_fqdn" {
  description = "Main production cutover FQDN (ecs.emea.fedex.com)"
  value       = module.route53.main_cutover_fqdn
}

output "aws_cloud_endpoint_fqdn" {
  description = "Primary AWS Cloud Endpoint FQDN (ecs.aws.emea.fedex.com)"
  value       = module.route53.aws_cloud_endpoint_fqdn
}