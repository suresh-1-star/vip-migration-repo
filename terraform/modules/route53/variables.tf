variable "vpc_id" {
  description = "VPC ID to attach to the Route 53 Private Hosted Zone"
  type        = string
}

variable "domain_name" {
  description = "Primary domain name for the Private Hosted Zone"
  type        = string
  default     = "emea.fedex.com"
}

variable "alb_dns_name" {
  description = "DNS name of the internal AWS Load Balancer"
  type        = string
}

variable "alb_zone_id" {
  description = "Hosted zone ID of the internal AWS Load Balancer"
  type        = string
}

variable "tags" {
  description = "Tags to apply to Route 53 resources"
  type        = map(string)
  default     = {}
}