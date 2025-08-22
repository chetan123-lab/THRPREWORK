variable "aws_region" {
  type        = string
  description = "AWS region"
  default     = "us-east-2"
}

variable "environment" {
  type        = string
  description = "Environment name"
  default     = "dev"
}

variable "bucket_name" {
  type        = string
  description = "S3 bucket name"
}

variable "config_name"   { 
  type = string 
  description = "configuration naming"
}

variable "s3_log_bucket_name" {
  type        = string
  description = "S3 bucket name for CloudTrail logs"
}

variable "vpc_cidr_block" {
  type        = string
  description = "The CIDR block for the VPC"
  default     = "10.0.0.0/16"
}

variable "vpc_name" {
  type        = string
  default     = "example-vpc"
  description = "The name of the VPC"
}

variable "subnet_cidr_blocks" {
  type        = list(string)
  description = "List of subnet CIDRs"
 
}

variable "subnet_names" {
  type        = list(string)
  description = "List of subnet names"
}

variable "availability_zones" {
  type        = list(string)
  description = "List of AZs to use"
}


variable "igw_name" {
  type        = string
  description = "The name of the internet gateway"
  default     = "example-igw"
}

variable "route_table_name" {
  type        = string
  description = "The name of the route table"
  default     = "example-rt"
}

variable "sg_name" {
  type        = string
  description = "The name of the security group"
  default     = "example-sg"
}

variable "sg_description" {
  type        = string
  description = "The description of the security group"
  default     = "Allow all inbound and outbound traffic"
}

variable "key_name" {
  type        = string
  description = "The name of the key pair"
  default     = "example-key"
}

variable "public_key_path" {
  type        = string
  description = "The path to the public key file"
  default     = "~/.ssh/id_rsa.pub"
}

variable "instance_count" {
  type        = number
  description = "The number of EC2 instances to create"
  default     = 2  
}

variable "ami_id" {
  type        = string
  description = "The ID of the AMI"
  default     = "ami-0c55b159cbfafe1f0"
}

variable "instance_type" {
  type        = string
  description = "The type of the EC2 instance"
  default     = "t2.micro"
  
}

variable "instance_name" {
  type        = string
  description = "The name of the EC2 instance"
  default     = "example-ec2"  
}

variable "crawlers" {
  type = list(object({
    name        = string
    role_arn    = string
    database    = string
    s3_targets  = list(string)
    description = optional(string, "")
  }))
  description = "List of Glue Crawlers with configs"
}

variable "databases" {
  type = list(object({
    name         : string
    description  : optional(string)
    location_uri : optional(string)
    parameters   : optional(map(string))
  }))
   description = "List of Glue databases to create."

}

variable "admin_username" { 
  type = string 
  description = "admin username for redshift"
}

variable "admin_user_password" {
  type      = string
  description = "admin password for redshift"
  sensitive = true
}

variable "log_exports" { 
  type = list(string) 
  description = "list of exporting logs"
  default = ["userlog","connectionlog","useractivitylog"] 
}


variable "workgroups" {
  type = list(object({
    name                  = string
     namespace_name       = string
    base_capacity         = number  
    daily_runtime_hours   = number  
}))
  description = "List of workgroups with base RPU and expected daily runtime (hours)."
}

variable "tags_redshift" {
  type    = map(string)
  description = "tag for redshift"
  default = {}
}

variable "namespaces" {
  type = list(object({
    name          = string
    db_name       = string
    base_capacity = number
  }))
  description = "List of namespaces + workgroups for Redshift Serverless"
}

variable "trail_name" { 
  type        = string
  description = "Name of the CloudTrail"
  default     = "org-cloudtrail"
}

variable "is_organization_trail" {
  type        = bool
  description = "Whether to create an Organization Trail (requires AWS Organizations permissions)"
  default     = false
}

variable "s3_data_buckets" {
  type        = list(string)
  description = "List of S3 bucket names to capture object-level data events for"
  default     = []
}

variable "tags_cloudtrail" {
  type        = map(string)
  description = "Tags to apply"
  default     = {}
}

variable "account_id" {
  type        =  string
  description = "AWS account id"
}


variable "objects_stored_per_month" {
  type        = number
  description = "Estimated number of Data Catalog objects stored per month (for cost visibility)."
  default     = 338000  
}

variable "access_requests_per_month" {
  type        = number
  description = "Estimated number of Data Catalog access requests per month (for cost visibility)."
  default     = 10000000 
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
  description = "The type of the EC2 instance"
  default     = "ml.t2.medium"
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
}

variable "sns_topic_name" {
  type    = string
  description = "SNS topic naming"
}

variable "recorder_name" {
  type    = string
  description = "AWS Config recorder"
  default = "default"

}

variable "delivery_channel_name" {
  type    = string
  description = "AWS Config delivery channel"
  default = "default"
}

variable "delivery_frequency" {
  type    = string
  description = "AWS Config delivery frequency"
  default = "TwentyFour_Hours"

}

variable "all_supported" {
  type    = bool
  description = "AWS Config settings optional values"
  default = true
}

variable "include_global_resource_types" {
  type    = bool
  description = "AWS Config settings optional values"
  default = true
}

variable "resource_types" {
  type    = list(string)
  default = []
}

variable "enable_s3_protection" {
  type    = bool
  description = "enabling S3 protection"
  default = true
}





