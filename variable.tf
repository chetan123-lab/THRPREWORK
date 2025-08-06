variable "aws_region" {
  description = "AWS region"
  type        = string
  default     = "us-east-2"
}

variable "bucket_name" {
  description = "S3 bucket name"
  type        = string
  default     = "my-dev-bucket"
}

variable "environment" {
  description = "Environment name"
  type        = string
  default     = "dev"
}