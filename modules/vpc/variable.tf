variable "vpc_cidr_block" {
  description = "VPC CIDR block"
  type        = string
}

variable "vpc_name" {
  description = "Name of the VPC"
  type        = string
}

variable "subnet_cidr_blocks" {
  description = "List of subnet CIDRs"
  type        = list(string)
}

variable "subnet_names" {
  description = "List of subnet names"
  type        = list(string)
}

variable "availability_zones" {
  description = "List of AZs for subnets"
  type        = list(string)
}

variable "igw_name" {
  description = "Internet Gateway name"
  type        = string
}

variable "route_table_name" {
  description = "Route table name"
  type        = string
}
