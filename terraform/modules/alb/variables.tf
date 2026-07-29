# ------------------------------------------------------------------------------
# BASIC LOAD BALANCER CONFIGURATION
# ------------------------------------------------------------------------------
variable "name" {
  description = "Name of the Application Load Balancer"
  type        = string
}

variable "internal" {
  description = "Boolean flag to determine whether the ALB is internal or internet-facing"
  type        = bool
  default     = false
}

variable "vpc_id" {
  description = "VPC ID where the ALB resources are deployed"
  type        = string
}

variable "subnet_ids" {
  description = "List of public/private subnet IDs to attach to the ALB"
  type        = list(string)
}

variable "security_group_ids" {
  description = "List of security group IDs attached to the ALB"
  type        = list(string)
}

# ------------------------------------------------------------------------------
# SSL / TLS CONFIGURATION (TSK-401 AUDIT COMPLIANCE)
# ------------------------------------------------------------------------------
variable "certificate_arn" {
  description = "TSK-401: ACM Certificate ARN for the HTTPS (443) listener"
  type        = string
}

variable "ssl_policy" {
  description = "Security policy for HTTPS listener"
  type        = string
  default     = "ELBSecurityPolicy-TLS13-1-2-2021-06"
}

# ------------------------------------------------------------------------------
# TAGGING
# ------------------------------------------------------------------------------
variable "tags" {
  description = "Map of tags to assign to ALB resources"
  type        = map(string)
  default     = {}
}

variable "target_group_arn" {
  description = "ARN of the target group to attach to the ALB HTTP listener"
  type        = string
}