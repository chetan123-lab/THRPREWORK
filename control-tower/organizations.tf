# Create AWS Organization
resource "aws_organizations_organization" "main" {
  aws_service_access_principals = [
    "cloudtrail.amazonaws.com",
    "config.amazonaws.com",
    "controltower.amazonaws.com",
    "sso.amazonaws.com",
    "servicecatalog.amazonaws.com",
    "guardduty.amazonaws.com",
    "securityhub.amazonaws.com",
    "member.org.stacksets.cloudformation.amazonaws.com"
  ]
  enabled_policy_types = var.enabled_policy_types
  feature_set         = var.organization_feature_set

  lifecycle {
    prevent_destroy = true
  }
}

resource "aws_organizations_account" "log_archive" {
  name      = var.log_archive_account_name
  email     = var.log_archive_email
  role_name = "OrganizationAccountAccessRole"

  parent_id = aws_organizations_organization.main.roots[0].id

  depends_on = [aws_organizations_organization.main]

  lifecycle {
    prevent_destroy = true
    ignore_changes = [parent_id]  # Let Control Tower manage placement
  }

  tags = merge(var.common_tags, var.additional_tags, {
    Name = var.log_archive_account_name
    Type = "LogArchive"
  })
}

# Create Audit Account
resource "aws_organizations_account" "audit" {
  name      = var.audit_account_name
  email     = var.audit_email
  role_name = "OrganizationAccountAccessRole"

  parent_id = aws_organizations_organization.main.roots[0].id

  depends_on = [aws_organizations_organization.main]

  lifecycle {
    prevent_destroy = true
    ignore_changes = [parent_id]  # Let Control Tower manage placement
  }

  tags = merge(var.common_tags, var.additional_tags, {
    Name = var.audit_account_name
    Type = "Audit"
  })
}

# Create AFT Management Account (for later AFT setup)
resource "aws_organizations_account" "aft_management" {
  name      = var.aft_management_account_name
  email     = var.aft_management_email
  role_name = "OrganizationAccountAccessRole"

  parent_id = "ou-pidn-i9p76sdy"

  depends_on = [aws_organizations_organization.main]

  lifecycle {
    prevent_destroy = true
  }

  tags = merge(var.common_tags, var.additional_tags, {
    Name = var.aft_management_account_name
    Type = "AFTManagement"
  })
}
# Custom OUs created after Control Tower is deployed
resource "aws_organizations_organizational_unit" "infrastructure" {
  name      = var.Infrastructure_ou_name
  parent_id = aws_organizations_organization.main.roots[0].id
  
  depends_on = [aws_controltower_landing_zone.main]

  tags = merge(var.common_tags, var.additional_tags, {
    Name = var.Infrastructure_ou_name
    Type = "CustomOU"
  })
}

resource "aws_organizations_organizational_unit" "data" {
  name      = var.Data_ou_name
  parent_id = aws_organizations_organization.main.roots[0].id
  
  depends_on = [aws_controltower_landing_zone.main]

  tags = merge(var.common_tags, var.additional_tags, {
    Name = var.Data_ou_name
    Type = "CustomOU"
  })
}

resource "aws_organizations_organizational_unit" "workloads" {
  name      = var.workloads_ou_name
  parent_id = aws_organizations_organization.main.roots[0].id
  
  depends_on = [aws_controltower_landing_zone.main]

  tags = merge(var.common_tags, var.additional_tags, {
    Name = var.workloads_ou_name
    Type = "CustomOU"
  })
}