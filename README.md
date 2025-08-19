# THRPREWORK
#Terraform Commands:
terraform init -reconfigure -backend-config backend/backend-dev.hcl
terraform workspace select dev || terraform workspace new dev
terraform plan --var-file envs/dev.tfvars
terraform apply --var-file envs/dev.tfvars --auto-approve
terraform destroy --var-file envs/dev.tfvars --auto-approve
terraform refresh  --var-file envs/dev.tfvars

#AWS Services:
1) awsconfig
2) certificate_manager
3) cloudtrail
4) ec2
5) glue crawler
6) glue data catalog
7) guardduty
8) iam
9) key_pair
10) kms_keys
11) lb
12) redshift
13) redshift serverless
14) s3
15) sagemaker
16) secret_manager
17) security_group
18) sns
19) vpc

Directory Structure:
THRPREWORK/
|--- modules/
|--- backend/
|--- envs/
|--- keys/
|--- modules/
|    |---  awsconfig
|    |---  certificate_manager
|    |---  cloudtrail
|    |---  ec2
|    |---  glue crawler
|    |---  glue data catalog
|    |---  guardduty
|    |---  iam
|    |---  key_pair
|    |---  kms_keys
|    |---  lb
|    |---  redshift
|    |---  rs-srvless
|    |---  s3
|    |---  sagemaker
|    |---  secret_manager
|    |---  security_group
|    |---  sns
|    |---  vpc
|--- scripts
|--- backend.tf
|--- main.tf
|--- README.md
|--- Screenshots.docx
|--- variable.tf

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