# Provider configuration
provider "aws" {
  region = var.aws_region
  access_key = ""
  secret_key = ""
}

# S3 module
module "s3" {
  source = "./modules/s3"

  environment = var.environment
  bucket_name = var.bucket_name
}