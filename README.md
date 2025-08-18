# THRPREWORK
#Terraform Commands:
terraform init -reconfigure -backend-config backend/backend-dev.hcl
terraform workspace select dev || terraform workspace new dev
terraform plan --var-file envs/dev.tfvars
terraform apply --var-file envs/dev.tfvars --auto-approve
terraform destroy --var-file envs/ dev.tfvars --auto-approve

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

