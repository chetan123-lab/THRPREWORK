output "ec2_ids" {
  value = aws_instance.example_ec2[*].id
}