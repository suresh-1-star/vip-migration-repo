# ==============================================================================
# CLUSTER OUTPUTS
# ==============================================================================

output "cluster_id" {
  description = "The ID of the ECS cluster"
  value       = aws_ecs_cluster.this.id
}

output "cluster_arn" {
  description = "The ARN of the ECS cluster"
  value       = aws_ecs_cluster.this.arn
}

output "cluster_name" {
  description = "The name of the ECS cluster"
  value       = aws_ecs_cluster.this.name
}

# ==============================================================================
# SERVICE OUTPUTS
# ==============================================================================

output "service_id" {
  description = "The ID of the ECS service"
  value       = aws_ecs_service.this.id
}

output "service_name" {
  description = "The name of the ECS service"
  value       = aws_ecs_service.this.name
}

# ==============================================================================
# TASK DEFINITION OUTPUTS
# ==============================================================================

output "task_definition_arn" {
  description = "Full ARN of the ECS Task Definition"
  value       = aws_ecs_task_definition.this.arn
}

output "task_definition_family" {
  description = "Family of the ECS Task Definition"
  value       = aws_ecs_task_definition.this.family
}