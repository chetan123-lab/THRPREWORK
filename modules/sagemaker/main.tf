resource "aws_sagemaker_notebook_instance" "example" {
  name          = var.notebook_instance_name
  instance_type = var.instance_type_sagemaker
  role_arn      = var.role_arn

  tags = {
    Name = var.notebook_instance_name
  }
}