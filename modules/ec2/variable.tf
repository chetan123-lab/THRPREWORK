variable "instance_count" {
  type = number
}

variable "instance_type" {
  type = string
}

variable "subnet_id" {
  type = list(string)
}

variable "sg_id" {
  type = string
}

variable "key_name" {
  type = string
}

variable "instance_name" {
  type = string
}

variable "user_data" {
  type        = string
  description = "User data script to run when the instance launches"
  default     = ""
}

variable "rhel_owner_id" {
  type        = string
  default     = "amazon" 
  description = "The ID of the account owning the RHEL AMIs"
}

variable "rhel_ami_name" {
  type        = string
  default     = "RHEL-9*"
  description = "The name pattern for RHEL AMIs"
}

variable "virtualization_type" {
  type        = string
  default     = "hvm"
  description = "The virtualization type for RHEL AMIs"
}

variable "architecture" {
  type        = string
  default     = "x86_64"
  description = "The architecture for RHEL AMIs"
}