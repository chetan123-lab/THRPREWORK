variable "secret_name" {
  type        = string
  description = "The name of the secret"
}

variable "secret_value" {
  type        = string
  description = "The value of the secret"
  sensitive   = true
}

variable "kms_key_id" {
  type        = string
  description = "The KMS key ID to use for encryption"
  default     = null
}

variable "recovery_window" {
  type        = number
  description = "The recovery window in days"
  default     = 30
}

variable "enable_rotation" {
  type        = bool
  description = "Whether to enable rotation"
  default     = false
}

variable "rotation_lambda_arn" {
  type        = string
  description = "The ARN of the Lambda function for rotation"
  default     = null
}

variable "policy" {
  type        = string
  description = "The policy document"
  default     = null
}

variable "rotation_period" {
  type        = number
  description = "The number of days between automatic rotations"
  default     = 30
}