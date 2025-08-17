output "namespace_names" {
  description = "All Redshift Serverless namespace names"
  value       = [for ns in aws_redshiftserverless_namespace.this : ns.namespace_name]
}

output "workgroup_names" {
  description = "All Redshift Serverless workgroup names"
  value       = [for wg in aws_redshiftserverless_workgroup.this : wg.workgroup_name]
}

output "workgroup_arns" {
  value = { for k, wg in aws_redshiftserverless_workgroup.this : k => wg.arn }
}

output "workgroup_endpoints" {
  description = "Endpoint address and port for each workgroup."
  value = {
    for k, wg in aws_redshiftserverless_workgroup.this :
    k => {
      address = wg.endpoint[0].address
      port    = wg.endpoint[0].port
    }
  }
}