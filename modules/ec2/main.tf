resource "aws_instance" "example_ec2" {

  count         = var.instance_count
  ami           = var.ami_id
  instance_type = var.instance_type
  subnet_id     = var.subnet_id[0]
  vpc_security_group_ids = [var.sg_id]
  key_name               = var.key_name
  user_data = var.user_data

  tags = {
    Name = "${var.instance_name}-${count.index}"
  }
}