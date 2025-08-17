output "recorder_id" {
  value       = aws_config_configuration_recorder.example.id
  description = "ID of the AWS Config recorder"
}

output "delivery_channel_id" {
  value       = aws_config_delivery_channel.example.id
  description = "ID of the AWS Config delivery channel"
}
