output "alb_arn" {
  description = "ARN of the application load balancer"
  value       = aws_lb.this.arn
}

output "https_listener_arn" {
  description = "ARN of the HTTPS listener"
  value       = aws_lb_listener.https.arn
}

output "alb_dns_name" {
  description = "DNS name of the application load balancer"
  value       = aws_lb.this.dns_name
}

output "alb_zone_id" {
  description = "Canonical hosted zone ID of the load balancer"
  value       = aws_lb.this.zone_id
}