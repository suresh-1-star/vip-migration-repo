# ------------------------------------------------------------------------------
# TARGET GROUP CONFIGURATION
# ------------------------------------------------------------------------------
variable "name" {
  description = "Name of the target group (e.g., tg-ecs-backend-v1-staging)"
  type        = string
}

variable "port" {
  description = "Port on which targets receive traffic"
  type        = number
  default     = 80
}

variable "protocol" {
  description = "Protocol to use for routing traffic to targets"
  type        = string
  default     = "HTTP"
}

variable "vpc_id" {
  description = "ID of the VPC where the target group will be created"
  type        = string
}

variable "target_type" {
  description = "Target type: 'ip' (required for ECS Fargate), 'instance', or 'lambda'"
  type        = string
  default     = "ip"
}

variable "deregistration_delay" {
  description = "Amount of time (in seconds) for ELB to wait before changing state of deregistering target from draining to unused"
  type        = number
  default     = 30
}

# ------------------------------------------------------------------------------
# TSK-301 HEALTH CHECK STANDARDS (AUDIT COMPLIANT DEFAULTS)
# ------------------------------------------------------------------------------
variable "health_check_enabled" {
  description = "Indicates whether health checks are enabled"
  type        = bool
  default     = true
}

variable "health_check_path" {
  description = "TSK-301.1: Health check URI path on target application"
  type        = string
  default     = "/health"
}

variable "health_check_protocol" {
  description = "Protocol used for performing health checks"
  type        = string
  default     = "HTTP"
}

variable "health_check_matcher" {
  description = "TSK-301.2: Expected HTTP response status code for healthy state"
  type        = string
  default     = "200"
}

variable "health_check_interval" {
  description = "TSK-301.3: Time interval (seconds) between health check probes"
  type        = number
  default     = 15
}

variable "health_check_timeout" {
  description = "TSK-301.3: Timeout (seconds) waiting for health check response"
  type        = number
  default     = 5
}

variable "healthy_threshold" {
  description = "TSK-301.4: Number of consecutive successful checks to mark healthy"
  type        = number
  default     = 2
}

variable "unhealthy_threshold" {
  description = "TSK-301.4: Number of consecutive failed checks to mark unhealthy"
  type        = number
  default     = 3
}

# ------------------------------------------------------------------------------
# TAGGING
# ------------------------------------------------------------------------------
variable "tags" {
  description = "A map of tags to assign to the Target Group resource"
  type        = map(string)
  default     = {}
}