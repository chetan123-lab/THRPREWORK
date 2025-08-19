variable "recorder_name" {
  type        = string
  default     = "default"
  description = "AWS Config recorder name"
}

variable "delivery_channel_name" {
  type        = string
  default     = "default"
  description = "AWS Config delivery channel name"
}

variable "delivery_frequency" {
  type        = string
  default     = "TwentyFour_Hours"
  description = "Snapshot delivery frequency (One_Hour|Three_Hours|Six_Hours|Twelve_Hours|TwentyFour_Hours)"
}

variable "all_supported" {
  type        = bool
  default     = true
  description = "Record all supported resource types?"
}

variable "include_global_resource_types" {
  type        = bool
  default     = true
  description = "Include global resource types (IAM, etc.)?"
}

variable "resource_types" {
  type        = list(string)
  default     = null
  description = "Specific resource types to record (if all_supported = false)"
}

variable "bucket_id" {
  type        = string
  description = "S3 bucket name for AWS Config"
}

variable "iam_role" {
  type        = string
  description = "IAM Role ARN for AWS Config"
}

variable "sns_topic_arn" {
  type        = string
  default     = null
  description = "SNS topic ARN for AWS Config notifications (optional)"
}
