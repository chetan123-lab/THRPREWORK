output "s3_bucket_arn" {
  value       = aws_s3_bucket.example.arn
  description = "The ARN of the S3 bucket"
}

output "s3_bucket_name" {
  value       = aws_s3_bucket.example.id
  description = "The name of the S3 bucket"
}

output "bucket_name" {
  value = aws_s3_bucket.config_bucket.bucket
}

output "bucket_arn" {
  value = aws_s3_bucket.config_bucket.arn
}

output "logs_bucket_id" {
  value = aws_s3_bucket.logs.id
}

output "logs_bucket_arn" {
  value = aws_s3_bucket.logs.arn
}
