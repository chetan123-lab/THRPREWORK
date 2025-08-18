variable "catalog_id" {
  type        = string
  default     = null
  description = "Optional Data Catalog ID (account ID)."
}

variable "databases" {
  type = list(object({
    name         : string
    description  : optional(string)
    location_uri : optional(string)
    parameters   : optional(map(string))
  }))
  description = "Glue databases to create."
  default     = []
}

variable "objects_stored_per_month" {
  type        = number
  default     = 338000
  description = "Usage: objects stored per month."
}

variable "access_requests_per_month" {
  type        = number
  default     = 10000000
  description = "Usage: access requests per month."
}

