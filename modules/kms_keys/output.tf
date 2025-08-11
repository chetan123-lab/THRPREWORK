output "key_arn" {
  value       = aws_kms_key.example.arn
  description = "The ARN of the KMS key"
}

output "key_id" {
  value       = aws_kms_key.example.key_id
  description = "The ID of the KMS key"
}