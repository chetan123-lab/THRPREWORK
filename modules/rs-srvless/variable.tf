variable "namespace_name" { 
  type = string
}

variable "db_name" { 
  type = string 
}

variable "admin_username"{ 
  type = string 
}

variable "admin_user_password" {
  description = "Admin user password for Redshift Serverless"
  type        = string
  sensitive   = true
}

variable "default_iam_role_arn" { 
  type = string 
}

variable "additional_iam_role_arns" { 
  type = list(string) 
}

variable "log_exports"{ 
  type = list(string) 
}

variable "publicly_accessible" { 
  type = bool 
}

variable "workgroups" {
  type = list(object({
    name                = string
    namespace_name      = string 
    base_capacity       = number
    daily_runtime_hours = number
  }))
}

variable "tags_redshift" {
  type    = map(string)
}

variable "namespaces" {
  description = "List of namespaces + workgroups for Redshift Serverless"
  type = list(object({
    name          = string
    db_name       = string
    base_capacity = number
  }))
}