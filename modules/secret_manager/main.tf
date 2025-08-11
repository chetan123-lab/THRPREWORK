resource "aws_secretsmanager_secret" "example" {
  name = var.secret_name
}

resource "aws_secretsmanager_secret_version" "example" {
  secret_id     = aws_secretsmanager_secret.example.id
  secret_string = var.secret_value
}

resource "aws_secretsmanager_secret_rotation" "example" {
     count = var.enable_rotation ? 1 : 0
     secret_id = aws_secretsmanager_secret.example.id
     rotation_lambda_arn = var.rotation_lambda_arn
      rotation_rules {
         automatically_after_days = var.rotation_period
     } 
}

resource "aws_secretsmanager_secret_policy" "example" {
  count       = var.policy != null ? 1 : 0
  secret_arn  = aws_secretsmanager_secret.example.arn
  policy      = var.policy
}

