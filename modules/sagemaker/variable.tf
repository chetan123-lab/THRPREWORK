variable "notebook_instance_name" {
  type        = string
  description = "Name of the SageMaker notebook instance"
}

variable "instance_type_sagemaker" {
  type        = string
  description = "Type of the SageMaker notebook instance"
}

variable "role_arn" {
  type        = string
  description = "ID of the subnet for the SageMaker notebook role_arn"
}