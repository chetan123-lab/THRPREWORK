variable "name" {
  type        = string
  description = "Environment/Project name for tagging"
}

variable "sns_topic_name" {
  type        = string
  description = "Name of the SNS topic"
}

variable "display_name" {
  type        = string
  description = "Display name for SNS topic (optional)"
  default     = null
}