# Deploy Control Tower Landing Zone - CORRECTED
resource "aws_controltower_landing_zone" "main" {
  manifest_json = jsonencode({
    governedRegions = [var.aws_region]
    
    organizationStructure = {
      security = {
        name = var.security_ou_name
      }
      sandbox = {
        name = var.sandbox_ou_name
      }
    }
    
    centralizedLogging = {
      accountId = aws_organizations_account.log_archive.id
      enabled = true
      configurations = {
        loggingBucket = {
          retentionDays = 1
        }
        accessLoggingBucket = {
          retentionDays = 1
        }
      }
    }
    
    securityRoles = {
      accountId = aws_organizations_account.audit.id
    }
    
    accessManagement = {
      enabled = false
    }
  })

  version = var.control_tower_version

  timeouts {
    create = "${var.deployment_timeout_minutes}m"
    update = "${var.deployment_timeout_minutes}m"
    delete = "${var.deployment_timeout_minutes}m"
  }

  depends_on = [
    aws_organizations_organization.main,
    aws_organizations_account.log_archive,
    aws_organizations_account.audit,
    aws_iam_role.control_tower_admin,
    aws_iam_role_policy_attachment.control_tower_admin,
    aws_iam_role_policy.control_tower_admin_policy,
    aws_iam_role.stackset_admin
  ]
}