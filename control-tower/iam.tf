# Control Tower Admin Role - MUST use /service-role/ path
resource "aws_iam_role" "control_tower_admin" {
  name = "AWSControlTowerAdmin"
  path = "/service-role/"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Principal = {
          Service = "controltower.amazonaws.com"
        }
        Action = "sts:AssumeRole"
      }
    ]
  })

  tags = merge(var.common_tags, var.additional_tags, {
    Name = "AWSControlTowerAdmin"
  })
}

# Attach AWS managed policy
resource "aws_iam_role_policy_attachment" "control_tower_admin" {
  role       = aws_iam_role.control_tower_admin.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSControlTowerServiceRolePolicy"
}

# Additional inline policy required by Control Tower
resource "aws_iam_role_policy" "control_tower_admin_policy" {
  name = "AWSControlTowerAdminPolicy"
  role = aws_iam_role.control_tower_admin.id

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Action = "ec2:DescribeAvailabilityZones"
        Resource = "*"
      }
    ]
  })
}

# StackSet Administration Role
resource "aws_iam_role" "stackset_admin" {
  name = "AWSControlTowerStackSetRole"
  path = "/service-role/"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Principal = {
          Service = "cloudformation.amazonaws.com"
        }
        Action = "sts:AssumeRole"
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "stackset_admin" {
  role       = aws_iam_role.stackset_admin.name
  policy_arn = "arn:aws:iam::aws:policy/PowerUserAccess"
}

# CloudTrail Role
resource "aws_iam_role" "cloudtrail_role" {
  name = "AWSControlTowerCloudTrailRole"
  path = "/service-role/"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Principal = {
          Service = "cloudtrail.amazonaws.com"
        }
        Action = "sts:AssumeRole"
      }
    ]
  })
}

resource "aws_iam_role_policy" "cloudtrail_logs_policy" {
  name = "CloudWatchLogsPolicy"
  role = aws_iam_role.cloudtrail_role.id

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = [
          "logs:CreateLogStream",
          "logs:PutLogEvents"
        ]
        Resource = "arn:aws:logs:*:*:log-group:aws-controltower/CloudTrailLogs:*"
        Effect = "Allow"
      }
    ]
  })
}