output "certificate_arn" {
  value       = aws_acm_certificate.example.arn
  description = "The ARN of the certificate"
}

output "certificate_status" {
  value       = aws_acm_certificate.example.status
  description = "The status of the certificate"
}