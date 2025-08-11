variable "key_description" {
  type        = string
  description = "The description of the KMS key"
}

variable "key_alias" {
  type        = string
  description = "The alias of the KMS key"
}

variable "enable_key_rotation" {
  type        = bool
  description = "Whether to enable key rotation"
  default     = true
}