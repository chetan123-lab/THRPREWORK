output "vpc_id" {
  description = "The ID of the VPC"
  value       = aws_vpc.example_vpc.id
}

# All subnet IDs
output "subnet_ids" {
  description = "List of all subnet IDs"
  value       = aws_subnet.example_subnets[*].id
}

# Availability Zones of subnets
output "azs" {
  description = "Availability zones used for the subnets"
  value       = aws_subnet.example_subnets[*].availability_zone
}

