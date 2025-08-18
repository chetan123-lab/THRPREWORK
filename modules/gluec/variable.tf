variable "crawlers" {
  description = "List of Glue Crawlers"
  type = list(object({
    name        = string
    role_arn    = string
    database    = string
    s3_targets  = list(string)
    description = optional(string, "")
  }))
}