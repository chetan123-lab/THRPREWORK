data "aws_ami" "latest_rhel" {
  most_recent = true
  owners      = [var.rhel_owner_id]

  filter {
    name   = "name"
    values = [var.rhel_ami_name]
  }

  filter {
    name   = "virtualization-type"
    values = [var.virtualization_type] 
  }
   
  filter {
    name   = "architecture"
    values = [var.architecture]
  }
}

resource "aws_instance" "example_ec2" {

  count         = var.instance_count
  ami           = data.aws_ami.latest_rhel.id
  instance_type = var.instance_type
  subnet_id     = var.subnet_id[0]
  vpc_security_group_ids = [var.sg_id]
  key_name               = var.key_name
  user_data = var.user_data

  tags = {
    Name = "${var.instance_name}-${count.index}"
  }
}