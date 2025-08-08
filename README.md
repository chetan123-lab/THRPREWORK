# THRPREWORK
#Terraform Commands:
terraform plan --var-file dev.tfvars
terraform apply --var-file dev.tfvars --auto-approve
terraform destroy --var-file dev.tfvars --auto-approve

#AWS Services Created Till Now:
1)EC2
2)key_pair
3)S3
4)security_group
5)Redshift

#Directory Structure:
- THRPREWORK
    - modules
        - ec2
            - main.tf
            - output.tf
            - variable.tf
        - key_pair
        - redshift
            - main.tf
            - output.tf
            - variable.tf
        - s3
        - security_group
            - main.tf
            - output.tf
            - variable.tf
        - vpc
    - dev.tfvars
    - main.tf
    - README.md
    - Screenshots.docx
    - variable.tf
