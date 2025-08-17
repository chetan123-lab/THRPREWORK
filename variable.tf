variable "aws_region" {
  description = "AWS region"
  type        = string
  default     = "us-east-2"
}

variable "bucket_name" {
  description = "S3 bucket name"
  type        = string
  default     = "my-dev-bucket"
}

variable "environment" {
  description = "Environment name"
  type        = string
  default     = "dev"
}

variable "vpc_cidr_block" {
  type        = string
  default     = "10.0.0.0/16"
  description = "The CIDR block for the VPC"
}

variable "vpc_name" {
  type        = string
  default     = "example-vpc"
  description = "The name of the VPC"
}

variable "subnet_cidr_blocks" {
  description = "List of subnet CIDRs"
  type        = list(string)
}

variable "subnet_names" {
  description = "List of subnet names"
  type        = list(string)
}

variable "availability_zones" {
  description = "List of AZs to use"
  type        = list(string)
}


variable "igw_name" {
  type        = string
  default     = "example-igw"
  description = "The name of the internet gateway"
}

variable "route_table_name" {
  type        = string
  default     = "example-rt"
  description = "The name of the route table"
}

variable "sg_name" {
  type        = string
  default     = "example-sg"
  description = "The name of the security group"
}

variable "sg_description" {
  type        = string
  default     = "Allow all inbound and outbound traffic"
  description = "The description of the security group"
}

variable "key_name" {
  type        = string
  default     = "example-key"
  description = "The name of the key pair"
}

variable "public_key_path" {
  type        = string
  default     = "~/.ssh/id_rsa.pub"
  description = "The path to the public key file"
}

variable "instance_count" {
  type        = number
  default     = 2
  description = "The number of EC2 instances to create"
}

variable "ami_id" {
  type        = string
  default     = "ami-0c55b159cbfafe1f0"
  description = "The ID of the AMI"
}

variable "instance_type" {
  type        = string
  default     = "t2.micro"
  description = "The type of the EC2 instance"
}

variable "instance_name" {
  type        = string
  default     = "example-ec2"
  description = "The name of the EC2 instance"
}

variable "cluster_identifier" {
  type        = string
  description = "The identifier for the Redshift cluster"
}

variable "database_name" {
  type        = string
  description = "The name of the database"
}

variable "master_username" {
  type        = string
  description = "The master username for the Redshift cluster"
}

variable "master_password" {
  type        = string
  description = "The master password for the Redshift cluster"
  sensitive   = true
}

variable "node_type" {
  type        = string
  description = "The node type for the Redshift cluster"
}

variable "cluster_type" {
  type        = string
  description = "The cluster type for the Redshift cluster"
}


variable "publicly_accessible" {
  type        = bool
  description = "Whether the Redshift cluster is publicly accessible"
}

variable "skip_final_snapshot" {
  type        = bool
  description = "Whether to skip the final snapshot"
}

variable "secret_name" {
  type        = string
  description = "The name of the secret"
}

variable "secret_value" {
  type        = string
  description = "The value of the secret"
  sensitive   = true
}

variable "kms_key_id" {
  type        = string
  description = "The KMS key ID to use for encryption"
}

variable "recovery_window" {
  type        = number
  description = "The recovery window in days"
  default     = 30
}

variable "key_description" {
  type        = string
  description = "The description of the KMS key"
}

variable "key_alias" {
  type        = string
  description = "The alias of the KMS key"
}

variable "enable_key_rotation" {
  type        = bool
  description = "Whether to enable key rotation"
  default     = true
}

variable "domain_name" {
  type        = string
  description = "The domain name for the certificate"
}

variable "validation_method" {
  type        = string
  description = "The validation method for the certificate (DNS or EMAIL)"
  default     = "DNS"
}

variable "zone_id" {
  type        = string
  description = "The ID of the Route 53 zone"
  default     = null
}

variable "notebook_instance_name" {
  type        = string
  description = "Name of the SageMaker notebook instance"
}

variable "role_arn" {
  type        = string
  description = "ID of the subnet for the SageMaker notebook role_arn"
}

variable "instance_type_sagemaker" {
  type        = string
  default     = "ml.t2.medium"
  description = "The type of the EC2 instance"
}

variable "tags" {
  type        = map(string)
  description = "Tags to apply"
  default     = {}
}

variable "gwlb_name" {
  type        = string
  description = "Name prefix for Gateway Load Balancer"
}

variable "name_of_sns" {
  type        = string
  description = "Prefix/environment name (used for tagging)"
}

variable "display_name" {
  type        = string
  description = "SNS display name (shown in console and emails)"
  default     = null
}

variable "config_name"   { 
  type = string 
}

variable "create_sns" {
  type    = bool
  default = true
}

variable "sns_topic_name" {
  type    = string
  default = ""
}

variable "recorder_name" {
  type    = string
  default = "default"
}

variable "delivery_channel_name" {
  type    = string
  default = "default"
}

variable "delivery_frequency" {
  type    = string
  default = "TwentyFour_Hours"
}

variable "all_supported" {
  type    = bool
  default = true
}

variable "include_global_resource_types" {
  type    = bool
  default = true
}

variable "resource_types" {
  type    = list(string)
  default = []
}

variable "max_history" {
  type    = number
  default = 100000
}

variable "enable_s3_protection" {
  type    = bool
  default = true
}

variable "findings_bucket_arn" {
  type    = string
  default = null
}

variable "kms_key_arn" {
  type    = string
  default = null
}

variable "trail_name" {
  description = "Name of the CloudTrail"
  type        = string
  default     = "org-cloudtrail"
}

variable "s3_log_bucket_name" {
  description = "S3 bucket name for CloudTrail logs"
  type        = string
}

variable "s3_log_bucket_force_destroy" {
  description = "Force-destroy the log bucket on 'terraform destroy'"
  type        = bool
  default     = false
}

variable "is_organization_trail" {
  description = "Whether to create an Organization Trail (requires AWS Organizations permissions)"
  type        = bool
  default     = false
}

variable "s3_data_buckets" {
  description = "List of S3 bucket names to capture object-level data events for"
  type        = list(string)
  default     = []
}

variable "tags_cloudtrail" {
  type        = map(string)
  description = "Tags to apply"
  default     = {}
}

variable "account_id" {
  description = "AWS account id"
  type        = string
}

variable "namespace_name" { 
  type = string 
}

variable "db_name" { 
  type = string 
}

variable "admin_username" { 
  type = string 
}

variable "admin_user_password" {
  type      = string
  sensitive = true
}

variable "log_exports" { 
  type = list(string) 
  default = ["userlog","connectionlog","useractivitylog"] 
}

# Define multiple workgroups
variable "workgroups" {
  description = "List of workgroups with base RPU and expected daily runtime (hours)."
  type = list(object({
    name                  = string
     namespace_name       = string
    base_capacity         = number  
    daily_runtime_hours   = number  
}))
}

variable "tags_redshift" {
  type    = map(string)
  default = {}
}

variable "namespaces" {
  description = "List of namespaces + workgroups for Redshift Serverless"
  type = list(object({
    name          = string
    db_name       = string
    base_capacity = number
  }))
}