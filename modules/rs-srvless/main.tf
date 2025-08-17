locals {
  namespaces_map = { for ns in var.namespaces : ns.name => ns }

  wg_limits = {
    for wg in var.workgroups : wg.name => {
      daily_rpu_hours_cap = wg.base_capacity * wg.daily_runtime_hours
    }
  }
}

# Namespace per entry
resource "aws_redshiftserverless_namespace" "this" {
  for_each = local.namespaces_map

  namespace_name       = each.value.name
  db_name              = each.value.db_name
  admin_username       = var.admin_username
  admin_user_password  = var.admin_user_password

  default_iam_role_arn = var.default_iam_role_arn
  iam_roles            = distinct(concat([var.default_iam_role_arn], var.additional_iam_role_arns))

  log_exports = var.log_exports
  tags        = var.tags_redshift
}

# One workgroup per namespace
resource "aws_redshiftserverless_workgroup" "this" {
  for_each = { for wg in var.workgroups : wg.name => wg }

  workgroup_name      = each.value.name
  namespace_name      = aws_redshiftserverless_namespace.this[each.key].namespace_name 
  base_capacity       = each.value.base_capacity
  publicly_accessible = var.publicly_accessible

  config_parameter {
    parameter_key   = "require_ssl"
    parameter_value = "true"
  }

  tags = var.tags_redshift
  depends_on = [aws_redshiftserverless_namespace.this]
}

# Daily RPU-hours usage limit per workgroup
resource "aws_redshiftserverless_usage_limit" "daily_rpu" {
  for_each = aws_redshiftserverless_workgroup.this

  resource_arn = each.value.arn
  usage_type   = "serverless-compute"
  period       = "daily"
  amount = local.wg_limits[each.key].daily_rpu_hours_cap
  breach_action = "log"
}
