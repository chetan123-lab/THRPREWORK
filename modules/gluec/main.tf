resource "aws_glue_crawler" "this" {
  for_each = { for crawler in var.crawlers : crawler.name => crawler }

  name          = each.value.name
  role          = each.value.role_arn
  database_name = each.value.database
  description   = each.value.description

  dynamic "s3_target" {
    for_each = each.value.s3_targets
    content {
      path = s3_target.value
    }
  }

  schedule = null # add cron if needed

}