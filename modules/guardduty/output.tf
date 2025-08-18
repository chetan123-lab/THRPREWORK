output "guardduty_detector_id" {
  value = aws_guardduty_detector.this.id
}

output "s3_protection_feature_id" {
  value = try(aws_guardduty_detector_feature.s3_protection[0].id, null)
}