variable "trail_name" {
  type        = string
}

variable "log_bucket_id" {
  type        = string
}

variable "log_bucket_arn" {
  type        = string
}

variable "is_organization_trail" {
  type    = bool
  default = false
}

variable "enable_management_events" {
  type    = bool
  default = true
}

variable "management_read_write_type" {
  type    = string
  default = "All"
}

variable "enable_s3_data_events" {
  type    = bool
  default = true
}

variable "s3_data_buckets" {
  type    = list(string)
  default = []
}

variable "enable_insights" {
  type    = bool
  default = true
}

variable "enable_api_error_rate_insight" {
  type    = bool
  default = true
}

variable "tags" {
  type    = map(string)
  default = {}
}

variable "account_id" {
  type= string
  
}