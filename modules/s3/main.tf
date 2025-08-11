# S3 bucket
resource "aws_s3_bucket" "example" {
  bucket = "${var.environment}-${var.bucket_name}"
  force_destroy = true
}

# S3 bucket versioning
resource "aws_s3_bucket_versioning" "example" {
  bucket = aws_s3_bucket.example.id
  versioning_configuration {
    status = "Enabled"
  }
}

# S3 bucket server-side encryption configuration
resource "aws_s3_bucket_server_side_encryption_configuration" "this" {
  bucket = aws_s3_bucket.example.id

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
}

resource "aws_s3_bucket_public_access_block" "example" {
  bucket = aws_s3_bucket.example.id

  block_public_acls   = true
  block_public_policy = true
  ignore_public_acls  = true
  restrict_public_buckets = true
}

# S3 bucket lifecycle configuration
resource "aws_s3_bucket_lifecycle_configuration" "example" {
  bucket = aws_s3_bucket.example.id

  rule {
    id     = "TransitionToIntelligentTiering"
    status = "Enabled"

    transition {
      days          = 1
      storage_class = "INTELLIGENT_TIERING"
    }

    transition {
      days          = 30
      storage_class = "GLACIER"
    }
  }
}


