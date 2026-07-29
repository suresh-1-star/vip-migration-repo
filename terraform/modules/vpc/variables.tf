variable "name" {
  description = "VPC name"
  type        = string
}

variable "cidr_block" {
  description = "CIDR block for the VPC"
  type        = string
}

variable "public_subnet_cidrs" {
  description = "List of public subnet CIDRs"
  type        = list(string)
}

variable "private_subnet_cidrs" {
  description = "List of private subnet CIDRs"
  type        = list(string)
}

variable "availability_zones" {
  description = "List of Availability Zones to deploy subnets in"
  type        = list(string)
}

variable "tags" {
  description = "Tags to apply to the VPC and subnets"
  type        = map(string)
  default     = {}
}