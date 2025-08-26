#Bucket Configuration Values
environment  = "dev"
bucket_name  = "s3-us-west-2-thr"
aws_region   = "us-west-2"
config_name  = "s3-us-west-2-config-thr"
force_destroy = true

#Network Configuration Values
vpc_cidr_block   = "10.0.0.0/16"
vpc_name  = "dev-vpc-us-west2-thr"
subnet_cidr_blocks = ["10.0.1.0/24", "10.0.2.0/24"]
subnet_names  = ["subnet-a", "subnet-b"]
availability_zones  = ["us-west-2a", "us-west-2b"]
igw_name  = "dev-igw-us-west-2-thr"
route_table_name = "dev-rt-us-west-2-thr"
sg_name = "dev-sg-us-west-2-thr"
sg_description  = "Allow all inbound and outbound traffic"

#Public key and ec2 values
key_name = "example-key"
public_key_path = "keys/my-key.pub"
instance_count = 2
instance_type = "t3.micro"
instance_name = "dev-ec2-us-west-2-thr"
rhel_owner_id      = "309956199498"
rhel_ami_name      = "RHEL-9*"
virtualization_type = "hvm"
architecture       = "x86_64"


#redshift values
cluster_identifier  = "dev-rs-us-west-2-thr"
database_name  = "my_database"
master_username  = "my_username"
master_password  = "My_password2"
node_type  = "ra3.xlplus"
cluster_type  = "single-node"
publicly_accessible = false
skip_final_snapshot = true
secret_name     = "dev-secret-us-west-2-thr-v3"
secret_value    = "my_secret_value"

#KMS key Values
kms_key_id      = "arn:aws:kms:us-west-2:221082206963:key/KEY_ID"
recovery_window = 30
enable_rotation = true
rotation_lambda_arn = "arn:aws:lambda:us-west-2:221082206963:function:my_rotation_lambda"
rotation_period = 30
key_description = "My KMS key"
key_alias       = "my-kms-key-V3"
enable_key_rotation = true

#Certificate Manager
domain_name  = "chetan777.com"
validation_method = "DNS"
zone_id  = "ZONE_ID"

#sagemaker role values
role_arn = "arn:aws:iam::221082206963:role/dev-sgmkr-thr"
notebook_instance_name = "dev-sgmkr-us-west-2-thr"

#Gateway load balancer
gwlb_name    = "dev-gwlb-us-west-2-thr"
tags = {
  Environment = "dev"
  Project     = "gwlb-demo"
}


#SNS values
name_of_sns     = "dev-sns-us-west-2-thr"
sns_topic_name  = "dev-config-topic"
display_name    = "Dev AWS Config Notifications"

#AWS Config values
recorder_name   = "dev-config-recorder"
delivery_channel_name  = "dev-config-delivery"
delivery_frequency = "TwentyFour_Hours"
all_supported = true
include_global_resource_types = true
resource_types = null
max_history = 100000
enable_s3_protection = true

#cloudtrail
trail_name                = "dev-cldtrail-us-west-2-thr"
is_organization_trail     = false

# S3 log bucket configurations
s3_log_bucket_name        = "dev-cloudtrail-us-west-2-logs-thr" 
s3_log_bucket_force_destroy = false
s3_data_buckets = ["dev-s3-us-west-2-thr"]

enable_insights               = true
enable_api_error_rate_insight = true

tags_cloudtrail = {
  Environment = "dev"
  Owner       = "platform"
  Service     = "cloudtrail"
}

account_id = 221082206963

#Redshift serverless configurations
admin_username      = "adminuser"
admin_user_password = "ChangeMe-StrongPassw0rd!"
log_exports = ["userlog","connectionlog","useractivitylog"]
namespaces = [
  {
    name          = "rssrv-dev-40-rpu"
    db_name       = "dev-db40-us-west-2-thr"
    base_capacity = 40
  },
  {
    name          = "rssrv-dev-72-rpu"
    db_name       = "dev-db72-us-west-2-thr"
    base_capacity = 72
  }
]

workgroups = [
  {
    name                = "rssrv-dev-40-rpu"
    namespace_name      = "rssrv-dev-40-rpu"   
    base_capacity       = 40
    daily_runtime_hours = 8
  },
  {
    name                = "rssrv-dev-72-rpu"
    namespace_name      = "rssrv-dev-72-rpu"
    base_capacity       = 72
    daily_runtime_hours = 6
  }
]

tags_redshift = {
  Project = "analytics"
  Env     = "dev"
  Owner   = "data-team"
}

#glue configuations
crawlers = [
  {
    name        = "crawler-001"
    role_arn    = "arn:aws:iam::221082206963:role/glue-crawler-role"
    database    = "glue_db"
    s3_targets  = ["s3://dev-s3-us-west-2-thr/"]
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

#Athena configuration
athena_database_name = "dev_athena_db_thr"
athena_bucket_name   = "dev-athena-bucket-thr"