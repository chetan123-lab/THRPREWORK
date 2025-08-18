data "aws_caller_identity" "current" {}

resource "aws_kms_key" "example" {
  description             = var.key_description
  deletion_window_in_days = 30
  enable_key_rotation     = var.enable_key_rotation

  policy = jsonencode({
    Version = "2012-10-17",
    Id      = "key-default-1",
    Statement = [
      {
        Sid      = "AllowGuardDutyUseOfKey",
        Effect   = "Allow",
        Principal = {
          Service = "guardduty.amazonaws.com"
        },
        Action = [
          "kms:GenerateDataKey",
          "kms:Encrypt"
        ],
        Resource = "*"
      },
      {
        Sid      = "AllowRootAccountFullAccess",
        Effect   = "Allow",
        Principal = {
          AWS = "arn:aws:iam::${data.aws_caller_identity.current.account_id}:root"
        },
        Action   = "kms:*",
        Resource = "*"
      }
    ]
  })
}

resource "aws_kms_alias" "example" {
  name          = "alias/${var.key_alias}"
  target_key_id = aws_kms_key.example.key_id
}