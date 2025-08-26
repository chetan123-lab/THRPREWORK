variable "database_name" {
  type        = string
  description = "The name of the Athena database"
}

variable "bucket_name" {
  type        = string
  description = "The name of the S3 bucket for Athena query results"
}