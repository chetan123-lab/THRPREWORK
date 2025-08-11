# THRPREWORK
#Terraform Commands:
terraform plan --var-file dev.tfvars
terraform apply --var-file dev.tfvars --auto-approve
terraform destroy --var-file dev.tfvars --auto-approve

#AWS Services Created Till Now:
1)certificate_manager
2)ec2
3)iam
4)key_pair
5)kms_keys
6)redshift
7)s3
8)secret_manager
9)security_group
10)vpc
11)sagemaker

THRPREWORK/
|--- modules/
|    |--- certificate_manager/
|    |--- ec2/
|    |--- iam/
|    |--- key_pair/
|    |--- kms_keys/
|    |--- redshift/
|    |--- s3/
|    |--- sagemaker/
|    |--- secret_manager/
|    |--- security_group/
|    |--- vpc/
|--- dev.tfvars
|--- main.tf
|--- README.md
|--- Screenshots.docx
|--- variable.tf
