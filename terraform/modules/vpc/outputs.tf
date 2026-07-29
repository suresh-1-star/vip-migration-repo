# ==============================================================================
# VPC OUTPUTS
# ==============================================================================

output "vpc_id" {
  description = "The ID of the VPC"
  value       = aws_vpc.main.id
}

output "vpc_arn" {
  description = "The ARN of the VPC"
  value       = aws_vpc.main.arn
}

output "vpc_cidr_block" {
  description = "The primary CIDR block of the VPC"
  value       = aws_vpc.main.cidr_block
}

# ==============================================================================
# AVAILABILITY ZONE OUTPUTS
# ==============================================================================

output "azs" {
  description = "List of logical Availability Zones used by the subnets (e.g., us-east-1a)"
  value       = distinct(aws_subnet.public[*].availability_zone)
}

output "az_ids" {
  description = "List of physical Availability Zone IDs used by the subnets (e.g., use1-az1)"
  value       = distinct(aws_subnet.public[*].availability_zone_id)
}

# ==============================================================================
# SUBNET OUTPUTS (IDs, ARNs, & CIDRs)
# ==============================================================================

output "public_subnet_ids" {
  description = "List of IDs of public subnets"
  value       = aws_subnet.public[*].id
}

output "public_subnet_cidrs" {
  description = "List of CIDR blocks of public subnets"
  value       = aws_subnet.public[*].cidr_block
}

output "private_subnet_ids" {
  description = "List of IDs of private subnets"
  value       = aws_subnet.private[*].id
}

output "private_subnet_cidrs" {
  description = "List of CIDR blocks of private subnets"
  value       = aws_subnet.private[*].cidr_block
}

output "database_subnet_ids" {
  description = "List of IDs of database subnets (if applicable)"
  value       = try(aws_subnet.database[*].id, [])
}

# ==============================================================================
# ADVANCED AZ MAPPING OUTPUTS (Useful for dynamic loops)
# ==============================================================================

output "public_subnets_by_az" {
  description = "Map of public subnet IDs keyed by their Availability Zone name"
  value = {
    for s in aws_subnet.public : s.availability_zone => s.id
  }
}

output "private_subnets_by_az" {
  description = "Map of private subnet IDs keyed by their Availability Zone name"
  value = {
    for s in aws_subnet.private : s.availability_zone => s.id
  }
}

# ==============================================================================
# GATEWAY & ROUTING OUTPUTS
# ==============================================================================

output "internet_gateway_id" {
  description = "The ID of the Internet Gateway"
  value       = try(aws_internet_gateway.main[0].id, null)
}

output "nat_gateway_ids" {
  description = "List of Network Address Translation (NAT) Gateway IDs"
  value       = aws_nat_gateway.main[*].id
}

output "nat_public_ips" {
  description = "List of public Elastic IPs associated with the NAT Gateways"
  value       = aws_eip.nat[*].public_ip
}

output "public_route_table_ids" {
  description = "List of IDs of public route tables"
  value       = aws_route_table.public[*].id
}

output "private_route_table_ids" {
  description = "List of IDs of private route tables"
  value       = aws_route_table.private[*].id
}