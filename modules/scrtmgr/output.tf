output "secret_arn" {
  value       = aws_secretsmanager_secret.example.arn
  description = "The ARN of the secret"
}

output "secret_id" {
  value       = aws_secretsmanager_secret.example.id
  description = "The ID of the secret"
}