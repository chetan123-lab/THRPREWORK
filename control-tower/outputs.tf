output "organization_id" {
  description = "The ID of the AWS Organization"
  value       = aws_organizations_organization.main.id
}

output "organization_arn" {
  description = "The ARN of the AWS Organization"
  value       = aws_organizations_organization.main.arn
}

output "management_account_id" {
  description = "The management account ID"
  value       = data.aws_caller_identity.current.account_id
}

output "log_archive_account_id" {
  description = "The Log Archive account ID"
  value       = aws_organizations_account.log_archive.id
}

output "audit_account_id" {
  description = "The Audit account ID"
  value       = aws_organizations_account.audit.id
}

output "control_tower_landing_zone_arn" {
  description = "The ARN of the Control Tower Landing Zone"
  value       = aws_controltower_landing_zone.main.arn
}

output "control_tower_landing_zone_latest_available_version" {
  description = "The latest available version of Control Tower"
  value       = aws_controltower_landing_zone.main.latest_available_version
}

# Custom OU Outputs
output "infrastructure_ou_id" {
  description = "The ID of the Infrastructure Organizational Unit"
  value       = aws_organizations_organizational_unit.infrastructure.id
}

output "data_ou_id" {
  description = "The ID of the Data Organizational Unit"
  value       = aws_organizations_organizational_unit.data.id
}

output "workloads_ou_id" {
  description = "The ID of the Workloads Organizational Unit"
  value       = aws_organizations_organizational_unit.workloads.id
}

