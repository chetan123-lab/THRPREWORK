output "database_names" {
  description = "Names of the created Glue databases."
  value       = [for k, v in aws_glue_catalog_database.this : v.name]
}

output "database_arns" {
  description = "ARNs of the created Glue databases."
  value       = [for k, v in aws_glue_catalog_database.this : v.arn]
}

output "catalog_usage_summary" {
  description = "Echo of usage inputs for cost visibility."
  value = {
    objects_per_month  = var.objects_stored_per_month
    requests_per_month = var.access_requests_per_month
  }
}