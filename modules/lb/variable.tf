variable "name" {
  type        = string
  description = "GWLB name"
}

variable "vpc_id" {
  type        = string
  description = "VPC ID"
}

variable "endpoint_subnet_ids" {
  type        = list(string)
  description = "Subnets for GWLB endpoints (2 AZs)"
}

variable "tags" {
  type    = map(string)
  default = {}
}
