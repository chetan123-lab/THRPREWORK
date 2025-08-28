# Core Configuration
variable "aws_region" {
  description = "Primary AWS region for Control Tower"
  type        = string
  default     = "us-east-2"
  validation {
    condition = can(regex("^[a-z]{2}-[a-z]+-[0-9]$", var.aws_region))
    error_message = "AWS region must be in format like 'us-east-1'."
  }
}

variable "additional_regions" {
  description = "Additional regions to govern with Control Tower"
  type        = list(string)
  default     = ["us-west-2"]
}

# Organization Configuration
variable "organization_name" {
  description = "Name for your organization"
  type        = string
  default     = "MyOrganization"
}

variable "organization_feature_set" {
  description = "Organization feature set (ALL or CONSOLIDATED_BILLING)"
  type        = string
  default     = "ALL"
  validation {
    condition     = contains(["ALL", "CONSOLIDATED_BILLING"], var.organization_feature_set)
    error_message = "Feature set must be either ALL or CONSOLIDATED_BILLING."
  }
}

# Account Configuration
variable "log_archive_email" {
  description = "Email for Log Archive account (must be unique, never used in AWS)"
  type        = string
  validation {
    condition     = can(regex("^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\\.[a-zA-Z]{2,}$", var.log_archive_email))
    error_message = "Must be a valid email address."
  }
}

variable "audit_email" {
  description = "Email for Audit account (must be unique, never used in AWS)"
  type        = string
  validation {
    condition     = can(regex("^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\\.[a-zA-Z]{2,}$", var.audit_email))
    error_message = "Must be a valid email address."
  }
}

variable "aft_management_email" {
  description = "Email for AFT Management account (must be unique, never used in AWS)"
  type        = string
  validation {
    condition     = can(regex("^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\\.[a-zA-Z]{2,}$", var.aft_management_email))
    error_message = "Must be a valid email address."
  }
}

variable "log_archive_account_name" {
  description = "Name for the Log Archive account"
  type        = string
  default     = "Log Archive"
}

variable "audit_account_name" {
  description = "Name for the Audit account"
  type        = string
  default     = "Audit"
}

variable "aft_management_account_name" {
  description = "Name for the AFT Management account"
  type        = string
  default     = "AFT Management"
}

# Organizational Units Configuration
variable "security_ou_name" {
  description = "Name for the Security Organizational Unit"
  type        = string
  default     = "Security"
}

variable "sandbox_ou_name" {
  description = "Name for the Sandbox Organizational Unit"
  type        = string
  default     = "Sandbox"
}

variable "workloads_ou_name" {
  description = "Name for the Workloads Organizational Unit"
  type        = string
  default     = "Workloads"
}

# Logging Configuration
variable "log_retention_days" {
  description = "CloudTrail log retention in days"
  type        = number
  default     = 365
  validation {
    condition     = var.log_retention_days >= 1 && var.log_retention_days <= 3653
    error_message = "Log retention must be between 1 and 3653 days."
  }
}

variable "access_log_retention_days" {
  description = "Access log retention in days"
  type        = number
  default     = 365
  validation {
    condition     = var.access_log_retention_days >= 1 && var.access_log_retention_days <= 3653
    error_message = "Access log retention must be between 1 and 3653 days."
  }
}

# Control Tower Configuration
variable "control_tower_version" {
  description = "Control Tower landing zone version"
  type        = string
  default     = "3.3"
}

variable "enable_access_management" {
  description = "Enable AWS SSO (IAM Identity Center) access management"
  type        = bool
  default     = true
}

variable "enable_centralized_logging" {
  description = "Enable centralized logging"
  type        = bool
  default     = true
}

# Timeout Configuration
variable "deployment_timeout_minutes" {
  description = "Timeout for Control Tower deployment in minutes"
  type        = number
  default     = 60
  validation {
    condition     = var.deployment_timeout_minutes >= 30 && var.deployment_timeout_minutes <= 120
    error_message = "Deployment timeout must be between 30 and 120 minutes."
  }
}

# Tagging Configuration
variable "common_tags" {
  description = "Common tags to apply to all resources"
  type        = map(string)
  default = {
    Project     = "ControlTower"
    Environment = "Production"
    ManagedBy   = "Terraform"
  }
}

variable "additional_tags" {
  description = "Additional tags to apply to specific resources"
  type        = map(string)
  default     = {}
}

# Service Access Principals
variable "aws_service_access_principals" {
  description = "List of AWS service principals to enable for the organization"
  type        = list(string)
  default = [
    "cloudtrail.amazonaws.com",
    "config.amazonaws.com",
    "controltower.amazonaws.com",
    "sso.amazonaws.com",
    "servicecatalog.amazonaws.com",
    "guardduty.amazonaws.com",
    "securityhub.amazonaws.com"
  ]
}

variable "enabled_policy_types" {
  description = "List of policy types to enable for the organization"
  type        = list(string)
  default = [
    "SERVICE_CONTROL_POLICY",
    "TAG_POLICY"
  ]
}


variable "Infrastructure_ou_name" {
  description = "Name for the Infrastructure Organizational Unit"
  type        = string
  default     = "Infrastructure"
}

variable "Data_ou_name" {
  description = "Name for the Data Organizational Unit"
  type        = string
  default     = "Data"
}
