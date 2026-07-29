# ==============================================================================
# CLUSTER & SERVICE IDENTIFIERS
# ==============================================================================

variable "cluster_name" {
  description = "Name of the ECS cluster"
  type        = string
}

variable "service_name" {
  description = "Name of the ECS service"
  type        = string
}

variable "desired_count" {
  description = "Number of desired tasks running in the ECS service"
  type        = number
  default     = 1
}

# ==============================================================================
# TASK DEFINITION CONFIGURATION
# ==============================================================================

variable "task_family" {
  description = "Name/family of the ECS task definition"
  type        = string
}

variable "cpu" {
  description = "Fargate CPU units (e.g., '256', '512', '1024'). Must be a string."
  type        = string
  default     = "256"
}

variable "memory" {
  description = "Fargate Memory in MiB (e.g., '512', '1024', '2048'). Must be a string."
  type        = string
  default     = "512"
}

variable "execution_role_arn" {
  description = "IAM role ARN that gives ECS agent permission to pull images and write logs"
  type        = string
}

variable "task_role_arn" {
  description = "IAM role ARN that gives application containers permission to call AWS APIs"
  type        = string
  default     = null
}

# ==============================================================================
# CONTAINER SPECIFICATIONS
# ==============================================================================

variable "container_name" {
  description = "Name of the primary app container inside the task"
  type        = string
}

variable "container_image" {
  description = "Docker image URI (e.g., 123456789012.dkr.ecr.us-east-1.amazonaws.com/my-app:v1.0.0)"
  type        = string
}

variable "container_port" {
  description = "Port exposed by the container"
  type        = number
  default     = 80
}

# ==============================================================================
# NETWORK & SECURITY CONFIGURATION
# ==============================================================================

variable "subnet_ids" {
  description = "List of private subnet IDs where ECS Fargate tasks will be deployed"
  type        = list(string)
}

variable "security_group_id" {
  description = "Security Group ID attached to the ECS Fargate tasks (awsvpc network mode)"
  type        = string
}

# ==============================================================================
# OPTIONAL LOAD BALANCER ATTACHMENT
# ==============================================================================

variable "target_group_arn" {
  description = "Target Group ARN for the Application Load Balancer (leave null if worker service)"
  type        = string
  default     = null
}