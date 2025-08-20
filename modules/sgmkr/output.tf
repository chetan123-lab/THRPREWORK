output "notebook_instance_arn" {
  value       = aws_sagemaker_notebook_instance.example.arn
  description = "ARN of the SageMaker notebook instance"
}

output "notebook_instance_url" {
  value       = aws_sagemaker_notebook_instance.example.url
  description = "URL of the SageMaker notebook instance"
}