# Get current AWS account info
data "aws_caller_identity" "current" {}

# Get available regions
data "aws_regions" "available" {
  all_regions = false
}

# Generate random IDs for unique naming
resource "random_id" "suffix" {
  byte_length = 4
}