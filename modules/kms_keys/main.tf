resource "aws_kms_key" "example" {
  description             = var.key_description
  deletion_window_in_days = 30
  enable_key_rotation     = var.enable_key_rotation
}

resource "aws_kms_alias" "example" {
  name          = "alias/${var.key_alias}"
  target_key_id = aws_kms_key.example.key_id
}