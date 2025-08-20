resource "aws_redshift_cluster" "example" {
  cluster_identifier      = var.cluster_identifier
  database_name           = var.database_name
  master_username         = var.master_username
  master_password         = var.master_password
  node_type               = var.node_type
  cluster_type            = var.cluster_type
  publicly_accessible     = var.publicly_accessible
  skip_final_snapshot     = var.skip_final_snapshot
}
