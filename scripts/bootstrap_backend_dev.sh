# Variables — change to your names/region
BUCKET_NAME="dev-s3-us-west-2-tfstate-bucket-thr"
AWS_REGION="us-west-2"

# 1. Create S3 bucket for Terraform state
aws s3api create-bucket \
  --bucket $BUCKET_NAME \
  --region $AWS_REGION \
  --create-bucket-configuration LocationConstraint=$AWS_REGION

# 2. Enable versioning (recommended for state history)
aws s3api put-bucket-versioning \
  --bucket $BUCKET_NAME \
  --versioning-configuration Status=Enabled
