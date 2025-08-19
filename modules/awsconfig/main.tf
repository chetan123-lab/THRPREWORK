# AWS Config Recorder
resource "aws_config_configuration_recorder" "example" {
  name     = var.recorder_name
  role_arn = var.iam_role

  recording_group {
    all_supported                 = var.all_supported
    include_global_resource_types = var.include_global_resource_types

    # resource_types is just an argument, not a block
    resource_types = var.resource_types
  }
}

# Delivery Channel
resource "aws_config_delivery_channel" "example" {
  name           = var.delivery_channel_name
  s3_bucket_name = var.bucket_id

  snapshot_delivery_properties {
    delivery_frequency = var.delivery_frequency
  }

  # sns_topic_arn is an attribute, not a block
  sns_topic_arn = var.sns_topic_arn
  depends_on = [aws_config_configuration_recorder.example]
}

# Recorder Status (enable)
resource "aws_config_configuration_recorder_status" "example" {
  is_enabled = true
  name       = aws_config_configuration_recorder.example.name
  depends_on = [ aws_config_delivery_channel.example ]
}
