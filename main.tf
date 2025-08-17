# Provider configuration
provider "aws" {
  region = var.aws_region
}

module "iam" {
  source = "./modules/iam"
  bucket_name = var.bucket_name
  environment = var.environment
}

# S3 module
module "s3" {
  source = "./modules/s3"
  environment  =  var.environment
  bucket_name  =  var.bucket_name
  config_name =   var.config_name
  account_id = var.account_id
  logs_bucket_name = var.s3_log_bucket_name
}


module "vpc" {
  source             = "./modules/vpc"
  vpc_cidr_block     = var.vpc_cidr_block   
  vpc_name           = var.vpc_name
  subnet_cidr_blocks = var.subnet_cidr_blocks
  subnet_names       = var.subnet_names
  availability_zones = var.availability_zones
  igw_name           = var.igw_name
  route_table_name   = var.route_table_name
}



module "security_group" {
  source        = "./modules/security_group"
  sg_name       = var.sg_name
  sg_description = var.sg_description
  vpc_id        = module.vpc.vpc_id
  depends_on    = [module.vpc]
}

module "rs_srvless" {
  source = "./modules/rs-srvless"
  namespace_name  = var.namespace_name
  db_name = var.db_name
  admin_username = var.admin_username
  admin_user_password  = var.admin_user_password
  default_iam_role_arn = module.iam.redshift_default_role_arn
  additional_iam_role_arns  = [module.iam.redshift_analytics_role_arn]
  log_exports = var.log_exports
  workgroups = var.workgroups
  publicly_accessible  = var.publicly_accessible
  namespaces = var.namespaces
  tags_redshift = var.tags_redshift
}

/*
module "cloudtrail" {
  source                    = "./modules/cloudtrail"

  trail_name                = var.trail_name
  log_bucket_id             = module.s3.logs_bucket_id
  log_bucket_arn            = module.s3.logs_bucket_arn
  is_organization_trail     = var.is_organization_trail
  enable_management_events  = true
  management_read_write_type = "All"
  enable_s3_data_events     = true
  s3_data_buckets           = var.s3_data_buckets
  enable_insights           = true
  enable_api_error_rate_insight = true
  tags                      = var.tags_cloudtrail
  account_id = var.account_id
}


module "kms_keys" {
  source = "./modules/kms_keys"
  key_description = var.key_description
  key_alias = var.key_alias
  enable_key_rotation = var.enable_key_rotation
}

module "guardduty" {
  source = "./modules/guardduty"
  enable_s3_protection = var.enable_s3_protection
}


module "sns" {
  source          = "./modules/sns"
  name            = var.name_of_sns
  sns_topic_name  = var.sns_topic_name
  display_name    = var.display_name
}

module "awsconfig" {
  source                   = "./modules/awsconfig"  
  
  name                     = var.config_name
  recorder_name            = var.recorder_name
  delivery_channel_name    = var.delivery_channel_name
  delivery_frequency       = var.delivery_frequency
  all_supported            = var.all_supported
  include_global_resource_types = var.include_global_resource_types
  resource_types           = var.resource_types
  max_history              = var.max_history

  bucket_id   = module.s3.bucket_name
  iam_role    = module.iam.iam_role_arn
  sns_topic_arn = module.sns.sns_topic_arn
}


module "gwlb" {
  source              = "./modules/lb"
  
  name                = var.gwlb_name
  vpc_id              = module.vpc.vpc_id
  endpoint_subnet_ids = module.vpc.subnet_ids
  tags                = var.tags
}

module "key_pair" {
  source          = "./modules/key_pair"
  key_name        = var.key_name
  public_key_path = var.public_key_path
}

module "ec2" {
  source        = "./modules/ec2"
  instance_count = var.instance_count
  ami_id         = var.ami_id
  instance_type  = var.instance_type
  subnet_id      = module.vpc.subnet_id
  sg_id          = module.security_group.sg_id
  key_name       = module.key_pair.key_name
  instance_name  = var.instance_name
  depends_on     = [module.vpc, module.security_group, module.key_pair]
}

module "redshift" {
  source = "./modules/redshift"
  
  cluster_identifier = var.cluster_identifier
  database_name  = var.database_name
  master_username  = var.master_username
  master_password  = var.master_password
  node_type  = var.node_type
  cluster_type  = var.cluster_type
  publicly_accessible  = var.publicly_accessible
  skip_final_snapshot  = var.skip_final_snapshot
}

module "secret_manager" {
  source = "./modules/secret_manager"
  secret_name  = var.secret_name
  secret_value = var.secret_value
  kms_key_id  = var.kms_key_id
  recovery_window = var.recovery_window
}



module "certificate_manager" {
  source = "./modules/certificate_manager"
  domain_name       = var.domain_name
  validation_method = var.validation_method
  zone_id = var.zone_id
}



module "sagemaker" {
  source = "./modules/sagemaker"
  notebook_instance_name  =  var.notebook_instance_name
  instance_type_sagemaker = var.instance_type_sagemaker
  role_arn  = var.role_arn
}

*/