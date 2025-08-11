output "s3_access_role_arn" {
  value       = aws_iam_role.s3_access_role.arn
  description = "ARN of the S3 access role"
}

output "s3_access_policy_arn" {
  value       = aws_iam_policy.s3_access_policy.arn
  description = "ARN of the S3 access policy"
}