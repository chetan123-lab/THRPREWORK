output "redshift_cluster_id" {
  value       = aws_redshift_cluster.example.id
  description = "The ID of the Redshift cluster"
}

output "redshift_cluster_endpoint" {
  value       = aws_redshift_cluster.example.endpoint
  description = "The endpoint of the Redshift cluster"
}
