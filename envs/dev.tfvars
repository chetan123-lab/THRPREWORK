environment   = "dev"
bucket_name   = "landingzonefordev"
backend_bucket = "my-terraform-state-bucket"
dynamodb_table_name = "terraform-locks"
aws_region     = "us-west-2"
vpc_cidr_block   = "10.0.0.0/16"
vpc_name  = "example-vpc"
subnet_cidr_blocks = ["10.0.1.0/24", "10.0.2.0/24"]
subnet_names  = ["subnet-a", "subnet-b"]
availability_zones  = ["us-west-2a", "us-west-2b"]
igw_name  = "example-igw"
route_table_name = "example-rt"
sg_name = "example-sg"
sg_description  = "Allow all inbound and outbound traffic"
key_name = "example-key"
public_key_path = "keys/my-key.pub"
instance_count = 2
ami_id = "ami-0987e9d53da324257"
instance_type = "t2.micro"
instance_name = "example-ec2"
cluster_identifier  = "my-redshift-cluster"
database_name  = "my_database"
master_username  = "my_username"
master_password  = "My_password2"
node_type  = "ra3.xlplus"
cluster_type  = "single-node"
publicly_accessible = true
skip_final_snapshot = true
secret_name     = "my_secret_vv16"
secret_value    = "my_secret_value"
kms_key_id      = "arn:aws:kms:us-west-2:221082206963:key/KEY_ID"
recovery_window = 30
enable_rotation = true
rotation_lambda_arn = "arn:aws:lambda:us-west-2:221082206963:function:my_rotation_lambda"
rotation_period = 30
key_description = "My KMS key"
key_alias       = "my-kms-key-V3"
enable_key_rotation = true
domain_name  = "chetan777.com"
validation_method = "DNS"
zone_id  = "ZONE_ID"
role_arn = "arn:aws:iam::221082206963:role/sagemaker-execution-role"
notebook_instance_name = "example-notebook-instance"
gwlb_name    = "dev-gwlb"
tags = {
  Environment = "dev"
  Project     = "gwlb-demo"
}
config_name = "devawsconfig"
force_destroy = true
name_of_sns     = "dev-sns"
sns_topic_name  = "dev-config-topic"
display_name    = "Dev AWS Config Notifications"
recorder_name   = "dev-config-recorder"
delivery_channel_name  = "dev-config-delivery"
delivery_frequency = "TwentyFour_Hours"
all_supported = true
include_global_resource_types = true
resource_types = null
max_history = 100000
enable_s3_protection = true

trail_name                = "dev-cloudtrail"
is_organization_trail     = false

# S3 log bucket
s3_log_bucket_name        = "dev-cloudtrail-logs-123456789012" 
s3_log_bucket_force_destroy = false

s3_data_buckets = ["landingzonefordev"]

enable_insights               = true
enable_api_error_rate_insight = true

tags_cloudtrail = {
  Environment = "dev"
  Owner       = "platform"
  Service     = "cloudtrail"
}
account_id = 221082206963

namespace_name = "rssrv-dev"
db_name        = "devdb"

admin_username      = "adminuser"
admin_user_password = "ChangeMe-StrongPassw0rd!"



# KMS & logging
log_exports = ["userlog","connectionlog","useractivitylog"]

namespaces = [
  {
    name          = "rssrv-dev-40-rpu"
    db_name       = "devdb40"
    base_capacity = 40
  },
  {
    name          = "rssrv-dev-72-rpu"
    db_name       = "devdb72"
    base_capacity = 72
  }
]
# Two workgroups per your specs
workgroups = [
  {
    name                = "rssrv-dev-40-rpu"
    namespace_name      = "rssrv-dev-40rpu"   
    base_capacity       = 40
    daily_runtime_hours = 8
  },
  {
    name                = "rssrv-dev-72-rpu"
    namespace_name      = "rssrv-dev-72rpu"
    base_capacity       = 72
    daily_runtime_hours = 6
  }
]

tags_redshift = {
  Project = "analytics"
  Env     = "dev"
  Owner   = "data-team"
}

crawlers = [
  {
    name        = "crawler-001"
    role_arn    = "arn:aws:iam::221082206963:role/glue-crawler-role"
    database    = "glue_db"
    s3_targets  = ["s3://dev-landingzonefordev/"]
    description = "Crawler for dataset 1"
  }

]

databases = [
  {
    name        = "raw"
    description = "Raw zone tables discovered by crawlers."
    # location_uri can be used when integrating with Hive-style external locations; optional for Glue
    parameters  = {
      classification = "parquet"
      owner          = "data-eng"
    }
  },
  {
    name        = "curated"
    description = "Curated, business-ready datasets."
    parameters  = {
      domain = "finance"
    }
  }
]

objects_stored_per_month  = 338000
access_requests_per_month = 10000000