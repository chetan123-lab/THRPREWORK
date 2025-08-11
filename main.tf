# Provider configuration
provider "aws" {
  region = var.aws_region
  access_key = " "
  secret_key = " "
}

# S3 module
module "s3" {
  source = "./modules/s3"
  environment  =  var.environment
  bucket_name  =  var.bucket_name
}

module "vpc" {
  source            = "./modules/vpc"
  cidr_block        = var.vpc_cidr_block
  vpc_name          = var.vpc_name
  subnet_cidr_block = var.subnet_cidr_block
  subnet_name       = var.subnet_name
  availability_zone = var.availability_zone
  igw_name          = var.igw_name
  route_table_name  = var.route_table_name
}

module "security_group" {
  source        = "./modules/security_group"
  sg_name       = var.sg_name
  sg_description = var.sg_description
  vpc_id        = module.vpc.vpc_id
  depends_on    = [module.vpc]
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

module "kms_keys" {
  source = "./modules/kms_keys"
  key_description = var.key_description
  key_alias = var.key_alias
  enable_key_rotation = var.enable_key_rotation
}

module "certificate_manager" {
  source = "./modules/certificate_manager"
  domain_name       = var.domain_name
  validation_method = var.validation_method
  zone_id = var.zone_id
}

module "iam" {
  source = "./modules/iam"

  bucket_name = var.bucket_name
  environment = var.environment
}