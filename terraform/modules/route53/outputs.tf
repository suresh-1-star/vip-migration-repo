output "zone_id" {
  description = "The ID of the Private Hosted Zone"
  value       = aws_route53_zone.private.zone_id
}

output "aws_cloud_endpoint_fqdn" {
  description = "FQDN of the primary AWS Cloud Alias Endpoint (ecs.aws.emea.fedex.com)"
  value       = aws_route53_record.aws_cloud_endpoint.fqdn
}

output "main_cutover_fqdn" {
  description = "FQDN of the main cutover record (ecs.emea.fedex.com)"
  value       = aws_route53_record.main_cutover_cname.fqdn
}