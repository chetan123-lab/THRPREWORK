resource "aws_sns_topic" "this" {
  name         = var.sns_topic_name
  display_name = var.display_name

  tags = {
    Name = var.sns_topic_name
    Env  = var.name
  }
}