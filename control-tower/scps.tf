# Service Control Policies for AWS Control Tower Organization

# Data sources for existing OUs
data "aws_organizations_organizational_units" "root" {
  parent_id = aws_organizations_organization.main.roots[0].id
}

data "aws_organizations_organizational_unit" "security" {
  name      = var.security_ou_name
  parent_id = aws_organizations_organization.main.roots[0].id
  depends_on = [aws_controltower_landing_zone.main]
}

data "aws_organizations_organizational_unit" "sandbox" {
  name      = var.sandbox_ou_name
  parent_id = aws_organizations_organization.main.roots[0].id
  depends_on = [aws_controltower_landing_zone.main]
}

# Variables for SCP customization
variable "allowed_regions" {
  description = "List of AWS regions to allow access to"
  type        = list(string)
  default     = [
    "us-east-1",
    "us-east-2", 
    "us-west-1",
    "us-west-2",
    "eu-west-1",
    "eu-central-1"
  ]
}

variable "sandbox_allowed_instance_types" {
  description = "Instance types allowed in sandbox accounts"
  type        = list(string)
  default     = [
    "t2.nano",
    "t2.micro",
    "t3.nano", 
    "t3.micro"
  ]
}

variable "max_ebs_volume_size_sandbox" {
  description = "Maximum EBS volume size in GB for sandbox accounts"
  type        = number
  default     = 10
}

# Baseline Security Policy - Applied to all accounts
resource "aws_organizations_policy" "baseline_security" {
  name        = "BaselineSecurityPolicy"
  description = "Baseline security controls applied to all accounts"
  type        = "SERVICE_CONTROL_POLICY"

  content = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Sid       = "DenyRootAccountUsage"
        Effect    = "Deny"
        Principal = "*"
        Action = [
          "iam:CreateAccessKey",
          "iam:DeleteAccessKey",
          "iam:UpdateAccessKey",
          "iam:CreateLoginProfile",
          "iam:DeleteLoginProfile",
          "iam:UpdateLoginProfile"
        ]
        Resource = [
          "arn:aws:iam::*:user/root"
        ]
      },
      {
        Sid    = "DenyDisableCloudTrail"
        Effect = "Deny"
        Action = [
          "cloudtrail:StopLogging",
          "cloudtrail:DeleteTrail",
          "cloudtrail:PutEventSelectors"
        ]
        Resource = "*"
        Condition = {
          StringNotEquals = {
            "aws:PrincipalOrgID" = aws_organizations_organization.main.id
          }
        }
      },
      {
        Sid    = "DenyDisableConfig"
        Effect = "Deny"
        Action = [
          "config:DeleteConfigurationRecorder",
          "config:DeleteDeliveryChannel",
          "config:StopConfigurationRecorder"
        ]
        Resource = "*"
      },
      {
        Sid    = "DenyDisableGuardDuty"
        Effect = "Deny"
        Action = [
          "guardduty:DeleteDetector",
          "guardduty:DeleteInvitations",
          "guardduty:DeleteMembers",
          "guardduty:DisassociateFromMasterAccount",
          "guardduty:DisassociateMembers",
          "guardduty:StopMonitoringMembers",
          "guardduty:UpdateDetector"
        ]
        Resource = "*"
      },
      {
        Sid    = "DenyLeaveOrganization"
        Effect = "Deny"
        Action = [
          "organizations:LeaveOrganization"
        ]
        Resource = "*"
      },
      {
        Sid    = "DenyHighRiskRegions"
        Effect = "Deny"
        Action = "*"
        Resource = "*"
        Condition = {
          StringNotEquals = {
            "aws:RequestedRegion" = var.allowed_regions
          }
        }
        NotAction = [
          "iam:*",
          "cloudfront:*",
          "route53:*",
          "support:*",
          "trustedadvisor:*"
        ]
      }
    ]
  })

  tags = merge(var.common_tags, {
    Name = "BaselineSecurityPolicy"
    Type = "SCP"
  })
}

# Sandbox Restrictions Policy
resource "aws_organizations_policy" "sandbox_restrictions" {
  name        = "SandboxRestrictionsPolicy"
  description = "Restrictions for sandbox accounts to prevent costly services"
  type        = "SERVICE_CONTROL_POLICY"

  content = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Sid    = "DenyExpensiveServices"
        Effect = "Deny"
        Action = [
          "ec2:RunInstances",
          "ec2:StartInstances",
          "rds:CreateDBInstance",
          "rds:CreateDBCluster",
          "redshift:CreateCluster",
          "elasticache:CreateCacheCluster",
          "elasticache:CreateReplicationGroup",
          "cloudfront:CreateDistribution",
          "globalaccelerator:CreateAccelerator",
          "directconnect:*",
          "workspaces:*",
          "workmail:*"
        ]
        Resource = "*"
        Condition = {
          StringNotEquals = {
            "ec2:InstanceType" = var.sandbox_allowed_instance_types
          }
        }
      },
      {
        Sid    = "LimitEBSVolumeSize"
        Effect = "Deny"
        Action = [
          "ec2:CreateVolume"
        ]
        Resource = "*"
        Condition = {
          NumericGreaterThan = {
            "ec2:VolumeSize" = tostring(var.max_ebs_volume_size_sandbox)
          }
        }
      },
      {
        Sid    = "DenyMarketplaceSubscriptions"
        Effect = "Deny"
        Action = [
          "aws-marketplace:Subscribe*",
          "aws-marketplace:Unsubscribe*"
        ]
        Resource = "*"
      },
      {
        Sid    = "RestrictIAMActions"
        Effect = "Deny"
        Action = [
          "iam:CreateRole",
          "iam:DeleteRole",
          "iam:AttachRolePolicy",
          "iam:DetachRolePolicy"
        ]
        Resource = [
          "arn:aws:iam::*:role/OrganizationAccountAccessRole",
          "arn:aws:iam::*:role/AWSControlTowerExecution",
          "arn:aws:iam::*:role/aws-controltower-*",
          "arn:aws:iam::*:role/*ControlTower*"
        ]
      }
    ]
  })

  tags = merge(var.common_tags, {
    Name = "SandboxRestrictionsPolicy"
    Type = "SCP"
  })
}

# Infrastructure OU Policy
resource "aws_organizations_policy" "infrastructure_policy" {
  name        = "InfrastructureOUPolicy"
  description = "Controls for Infrastructure OU accounts"
  type        = "SERVICE_CONTROL_POLICY"

  content = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Sid    = "DenyDangerousActions"
        Effect = "Deny"
        Action = [
          "iam:DeleteRole",
          "iam:DeleteUser",
          "iam:DeleteGroup"
        ]
        Resource = [
          "arn:aws:iam::*:role/OrganizationAccountAccessRole",
          "arn:aws:iam::*:role/AWSControlTowerExecution*",
          "arn:aws:iam::*:role/*ControlTower*"
        ]
      },
      {
        Sid    = "RestrictInstanceTypes"
        Effect = "Deny"
        Action = [
          "ec2:RunInstances"
        ]
        Resource = "arn:aws:ec2:*:*:instance/*"
        Condition = {
          "ForAllValues:StringNotLike" = {
            "ec2:InstanceType" = [
              "t2.*",
              "t3.*",
              "t3a.*",
              "m5.*",
              "m5a.*",
              "c5.*",
              "r5.*"
            ]
          }
        }
      }
    ]
  })

  tags = merge(var.common_tags, {
    Name = "InfrastructureOUPolicy"
    Type = "SCP"
  })
}

# Data OU Policy
resource "aws_organizations_policy" "data_ou_policy" {
  name        = "DataOUPolicy"
  description = "Controls for Data OU accounts with data services focus"
  type        = "SERVICE_CONTROL_POLICY"

  content = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Sid    = "EnforceS3Encryption"
        Effect = "Deny"
        Action = [
          "s3:PutObject"
        ]
        Resource = "arn:aws:s3:::*/*"
        Condition = {
          StringNotEquals = {
            "s3:x-amz-server-side-encryption" = ["AES256", "aws:kms"]
          }
        }
      },
      {
        Sid    = "RequireS3BlockPublicAccess"
        Effect = "Deny"
        Action = [
          "s3:PutBucketPublicAccessBlock"
        ]
        Resource = "*"
        Condition = {
          Bool = {
            "s3:BlockPublicAcls" = "false"
          }
        }
      },
      {
        Sid    = "DenyPublicRDSInstances"
        Effect = "Deny"
        Action = [
          "rds:CreateDBInstance",
          "rds:ModifyDBInstance"
        ]
        Resource = "*"
        Condition = {
          Bool = {
            "rds:PubliclyAccessible" = "true"
          }
        }
      }
    ]
  })

  tags = merge(var.common_tags, {
    Name = "DataOUPolicy"
    Type = "SCP"
  })
}

# Workload OU Policy
resource "aws_organizations_policy" "workload_ou_policy" {
  name        = "WorkloadOUPolicy"
  description = "Controls for Workload OU accounts running applications"
  type        = "SERVICE_CONTROL_POLICY"

  content = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Sid    = "RestrictInstanceSizes"
        Effect = "Deny"
        Action = [
          "ec2:RunInstances"
        ]
        Resource = "arn:aws:ec2:*:*:instance/*"
        Condition = {
          "ForAllValues:StringNotLike" = {
            "ec2:InstanceType" = [
              "t2.*",
              "t3.*",
              "t3a.*",
              "m5.*",
              "m5a.*",
              "m5n.*",
              "c5.*",
              "c5n.*"
            ]
          }
        }
      },
      {
        Sid    = "DenyUnencryptedStorage"
        Effect = "Deny"
        Action = [
          "ec2:CreateVolume",
          "ec2:RunInstances"
        ]
        Resource = "*"
        Condition = {
          Bool = {
            "ec2:Encrypted" = "false"
          }
        }
      },
      {
        Sid    = "RequireResourceTags"
        Effect = "Deny"
        Action = [
          "ec2:RunInstances",
          "ec2:CreateVolume"
        ]
        Resource = "*"
        Condition = {
          "ForAllValues:StringNotLike" = {
            "aws:TagKeys" = [
              "Project",
              "Environment", 
              "Owner"
            ]
          }
        }
      }
    ]
  })

  tags = merge(var.common_tags, {
    Name = "WorkloadOUPolicy"
    Type = "SCP"
  })
}

# Security OU Policy
resource "aws_organizations_policy" "security_ou_policy" {
  name        = "SecurityOUPolicy"
  description = "Minimal restrictions for Security OU (Audit/Log Archive accounts)"
  type        = "SERVICE_CONTROL_POLICY"

  content = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Sid    = "DenyModifySecurityRoles"
        Effect = "Deny"
        Action = [
          "iam:DeleteRole",
          "iam:UpdateRole",
          "iam:DetachRolePolicy",
          "iam:DeleteRolePolicy"
        ]
        Resource = [
          "arn:aws:iam::*:role/*ControlTower*",
          "arn:aws:iam::*:role/*CloudTrail*",
          "arn:aws:iam::*:role/*Config*",
          "arn:aws:iam::*:role/OrganizationAccountAccessRole"
        ]
      }
    ]
  })

  tags = merge(var.common_tags, {
    Name = "SecurityOUPolicy"
    Type = "SCP"
  })
}

# Policy Attachments
resource "aws_organizations_policy_attachment" "baseline_security_root" {
  policy_id = aws_organizations_policy.baseline_security.id
  target_id = aws_organizations_organization.main.roots[0].id
}

resource "aws_organizations_policy_attachment" "sandbox_restrictions" {
  policy_id = aws_organizations_policy.sandbox_restrictions.id
  target_id = data.aws_organizations_organizational_unit.sandbox.id
}

resource "aws_organizations_policy_attachment" "infrastructure_policy" {
  policy_id = aws_organizations_policy.infrastructure_policy.id
  target_id = aws_organizations_organizational_unit.infrastructure.id
}

resource "aws_organizations_policy_attachment" "data_ou_policy" {
  policy_id = aws_organizations_policy.data_ou_policy.id
  target_id = aws_organizations_organizational_unit.data.id
}

resource "aws_organizations_policy_attachment" "workload_ou_policy" {
  policy_id = aws_organizations_policy.workload_ou_policy.id
  target_id = aws_organizations_organizational_unit.workloads.id
}

resource "aws_organizations_policy_attachment" "security_ou_policy" {
  policy_id = aws_organizations_policy.security_ou_policy.id
  target_id = data.aws_organizations_organizational_unit.security.id
}

# Outputs
output "scp_policies" {
  description = "Created SCP policies with their IDs"
  value = {
    baseline_security = {
      id          = aws_organizations_policy.baseline_security.id
      arn         = aws_organizations_policy.baseline_security.arn
      attached_to = "Root"
    }
    sandbox_restrictions = {
      id          = aws_organizations_policy.sandbox_restrictions.id
      arn         = aws_organizations_policy.sandbox_restrictions.arn
      attached_to = "Sandbox OU"
    }
    infrastructure_policy = {
      id          = aws_organizations_policy.infrastructure_policy.id
      arn         = aws_organizations_policy.infrastructure_policy.arn
      attached_to = "Infrastructure OU"
    }
    data_ou_policy = {
      id          = aws_organizations_policy.data_ou_policy.id
      arn         = aws_organizations_policy.data_ou_policy.arn
      attached_to = "Data OU"
    }
    workload_ou_policy = {
      id          = aws_organizations_policy.workload_ou_policy.id
      arn         = aws_organizations_policy.workload_ou_policy.arn
      attached_to = "Workload OU"
    }
    security_ou_policy = {
      id          = aws_organizations_policy.security_ou_policy.id
      arn         = aws_organizations_policy.security_ou_policy.arn
      attached_to = "Security OU"
    }
  }
}