# Core Configuration
aws_region         = "us-east-2"
additional_regions = []  # Remove additional regions to reduce costs

# Organization Configuration
organization_name = "chetan-harsha-lab"

# Account Email Addresses
log_archive_email    = "venkata.m0414+logarchive@gmail.com"
audit_email         = "venkata.m0414+audit@gmail.com"
aft_management_email = "venkata.m0414+aftmanagement@gmail.com"

# Account Names
log_archive_account_name    = "Log Archive"
audit_account_name         = "Audit"
aft_management_account_name = "AFT Management"

# Organizational Unit Names
security_ou_name  = "Security"
Infrastructure_ou_name = "Infrastructure"
Data_ou_name = "Data"
workloads_ou_name = "Workload"

# Disable costly features
enable_centralized_logging = false  # This disables CloudTrail
enable_access_management   = false  # This disables SSO setup

# Minimal logging (but these won't be used since logging is disabled)
log_retention_days        = 30
access_log_retention_days = 30

# Control Tower Configuration
control_tower_version      = "3.3"
deployment_timeout_minutes = 60

# Minimal tagging
common_tags = {
  Project     = "ControlTower"
  Environment = "Lab"
  ManagedBy   = "Terraform"
}

additional_tags = {}

allowed_regions = [
  "us-east-2",
]

sandbox_allowed_instance_types = [
  "t2.nano",
  "t2.micro",
  "t3.nano",
  "t3.micro"
]

max_ebs_volume_size_sandbox = 10
enable_marketplace_restrictions = true
enable_encryption_requirements = true