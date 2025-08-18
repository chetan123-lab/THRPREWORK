output "s3_access_role_arn" {
  value       = aws_iam_role.s3_access_role.arn
  description = "ARN of the S3 access role"
}

output "s3_access_policy_arn" {
  value       = aws_iam_policy.s3_access_policy.arn
  description = "ARN of the S3 access policy"
}

output "iam_role_arn" {
  value       = aws_iam_role.config.arn
  description = "IAM role ARN for AWS Config"
}

output "redshift_default_role_arn" {
  description = "ARN of the default Redshift Serverless IAM role"
  value       = aws_iam_role.redshift_default.arn
}

output "redshift_analytics_role_arn" {
  description = "ARN of the analytics IAM role for Redshift Serverless"
  value       = aws_iam_role.redshift_analytics.arn
}

output "glue_role_arn" {
  description = "ARN of glue service"
  value       = aws_iam_role.glue_role.arn
}