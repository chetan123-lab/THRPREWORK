variable "bucket_name" {
  description = "S3 bucket name"
  type        = string
}

variable "environment" {
  description = "Environment name"
  type        = string
}

variable "config_name" { 
  type = string 
}

variable "force_destroy" {
  type    = bool
  default = false
}

variable "logs_bucket_name" {
  description = "Name of the S3 bucket"
  type        = string
}