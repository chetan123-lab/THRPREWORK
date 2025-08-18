data "aws_iam_policy_document" "trail_bucket_policy" {
  statement {
    sid     = "AWSCloudTrailAclCheck"
    effect  = "Allow"
    principals {
      type        = "Service"
      identifiers = ["cloudtrail.amazonaws.com"]
    }
    actions   = ["s3:GetBucketAcl"]
    resources = [var.log_bucket_arn]
  }

  statement {
    sid     = "AWSCloudTrailWrite"
    effect  = "Allow"
    principals {
      type        = "Service"
      identifiers = ["cloudtrail.amazonaws.com"]
    }
    actions = ["s3:PutObject"]
    resources = ["${var.log_bucket_arn}/AWSLogs/${var.account_id}/*"]
    condition {
      test     = "StringEquals"
      variable = "s3:x-amz-acl"
      values   = ["bucket-owner-full-control"]
    }
  }
}

resource "aws_s3_bucket_policy" "logs" {
  bucket = var.log_bucket_id
  policy = data.aws_iam_policy_document.trail_bucket_policy.json
}

resource "aws_cloudtrail" "this" {
  name                          = var.trail_name
  s3_bucket_name                = var.log_bucket_id
  include_global_service_events = true
  is_multi_region_trail         = true
  enable_log_file_validation    = true
  is_organization_trail         = var.is_organization_trail

  # Management events
  dynamic "event_selector" {
    for_each = var.enable_management_events ? [1] : []
    content {
      include_management_events = true
      read_write_type           = var.management_read_write_type
    }
  }

  # Data events - S3
  dynamic "event_selector" {
    for_each = var.enable_s3_data_events && length(var.s3_data_buckets) > 0 ? [1] : []
    content {
      include_management_events = false
      read_write_type           = "All"

      dynamic "data_resource" {
        for_each = var.s3_data_buckets
        content {
          type   = "AWS::S3::Object"
          values = ["arn:aws:s3:::${data_resource.value}/"]
        }
      }
    }
  }

  # Insights
  dynamic "insight_selector" {
    for_each = var.enable_insights ? [1] : []
    content {
      insight_type = "ApiCallRateInsight"
    }
  }

  dynamic "insight_selector" {
    for_each = var.enable_insights && var.enable_api_error_rate_insight ? [1] : []
    content {
      insight_type = "ApiErrorRateInsight"
    }
  }

  depends_on = [aws_s3_bucket_policy.logs]

  tags = merge(var.tags, { "Name" = var.trail_name })
}
