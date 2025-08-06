output "s3_bucket_arn" {
  value       = aws_s3_bucket.example.arn
  description = "The ARN of the S3 bucket"
}

output "s3_bucket_name" {
  value       = aws_s3_bucket.example.id
  description = "The name of the S3 bucket"
}