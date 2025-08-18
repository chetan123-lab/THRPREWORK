variable "instance_count" {
  type = number
}

variable "ami_id" {
  type = string
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