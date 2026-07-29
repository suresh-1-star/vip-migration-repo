output "arn" {
  description = "The ARN of the Target Group (used by ALB listener rules and ECS services)"
  value       = aws_lb_target_group.this.arn
}

output "arn_suffix" {
  description = "The ARN suffix for use with CloudWatch Metrics / Alarms"
  value       = aws_lb_target_group.this.arn_suffix
}

output "name" {
  description = "The name of the Target Group"
  value       = aws_lb_target_group.this.name
}

output "id" {
  description = "The ID of the Target Group"
  value       = aws_lb_target_group.this.id
}