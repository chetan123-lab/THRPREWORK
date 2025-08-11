variable "cluster_identifier" {
  type        = string
  description = "The identifier for the Redshift cluster"
}

variable "database_name" {
  type        = string
  description = "The name of the database"
}

variable "master_username" {
  type        = string
  description = "The master username for the Redshift cluster"
}

variable "master_password" {
  type        = string
  description = "The master password for the Redshift cluster"
  sensitive   = true
}

variable "node_type" {
  type        = string
  description = "The node type for the Redshift cluster"
}

variable "cluster_type" {
  type        = string
  description = "The cluster type for the Redshift cluster"
}


variable "publicly_accessible" {
  type        = bool
  description = "Whether the Redshift cluster is publicly accessible"
}

variable "skip_final_snapshot" {
  type        = bool
  description = "Whether to skip the final snapshot"
}
