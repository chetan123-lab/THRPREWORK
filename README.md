# THRPREWORK
#Terraform Commands:
terraform init -reconfigure -backend-config backend/backend-dev.hcl
terraform workspace select dev || terraform workspace new dev
terraform plan --var-file envs/dev.tfvars
terraform apply --var-file envs/dev.tfvars --auto-approve
terraform destroy --var-file envs/dev.tfvars --auto-approve
terraform refresh  --var-file envs/dev.tfvars

#AWS Services and description
1. IAM Module: Manages IAM roles and policies.
2. S3 Module: Configures S3 buckets for storage and logging.
3. VPC Module: Creates a VPC with subnets, internet gateways, and route tables.
4. Security Group Module: Defines security groups for EC2 instances.
5. Key Pair Module: Manages SSH key pairs for EC2 instances.
6. EC2 Module: Launches EC2 instances with specified configurations.
7. Glue Modules (gluedc and gluec): Configures AWS Glue databases and crawlers.
8. Redshift Serverless Module: Sets up Redshift Serverless workgroups and namespaces.
9. CloudTrail Module: Enables CloudTrail for auditing and logging.
10. KMS Keys Module: Manages KMS keys for encryption.
11. GuardDuty Module: Configures GuardDuty for threat detection.
12. SNS Module: Creates SNS topics for notifications.
13. AWS Config Module: Sets up AWS Config for resource tracking and compliance.
14. Gateway Load Balancer Module: Configures a Gateway Load Balancer.
15. Redshift Module: Creates a Redshift cluster.
16. Secrets Manager Module: Manages secrets in Secrets Manager.
17. Certificate Manager Module: Configures SSL/TLS certificates.
18. SageMaker Module: Sets up SageMaker notebook instances.
19. athena:For query to data

Directory Structure:
THRPREWORK/
|--- modules/
|--- backend/
|--- envs/
|--- keys/
|--- modules/
     |---  athena
|    |---  awsconfig
|    |---  certificate_manager
|    |---  cloudtrail
|    |---  ec2
|    |---  gluec
|    |---  gluedc
|    |---  guarduty
|    |---  iam
|    |---  key_pair
|    |---  kms_keys
|    |---  lb
|    |---  rs
|    |---  rs-srvless
|    |---  s3
|    |---  sgmkr
|    |---  scrtmgr
|    |---  sg
|    |---  sns
|    |---  vpc
|--- scripts
|--- backend.tf
|--- main.tf
|--- README.md
|--- Screenshots.docx
|--- variable.tf

#Naming convention:
environment-resourcename-region-purpose-name of company

#Command to check userdata script:
systemctl status nginx

#Steps to install tflint:
choco install tflint
tflint --version

#Steps to scan tflint:
tflint --recursive

#Step to disable tflint rule:
tflint --recursive --disable-rule terraform_required_version --disable-rule terraform_required_providers
Below warnings rule disbled:
1)
Warning: Missing version constraint for provider "aws" in `required_providers` (terraform_required_providers)

  on modules\vpc\main.tf line 40:
  40: resource "aws_route_table_association" "example_rta" {

Reference: https://github.com/terraform-linters/tflint-ruleset-terraform/blob/v0.12.0/docs/rules/terraform_required_providers.md

2)
Warning: terraform "required_version" attribute is required (terraform_required_version)

  on modules\awsconfig\main.tf line 1:

Reference: https://github.com/terraform-linters/tflint-ruleset-terraform/blob/v0.12.0/docs/rules/terraform_required_version.md

#Steps to install checkov:
pip install checkov

#steps to scan checkov in current directory:
checkov -d .