# Create Glue Databases
resource "aws_glue_catalog_database" "this" {
  for_each = { for db in var.databases : db.name => db }

  name        = each.value.name
  description = coalesce(try(each.value.description, null), "")

  dynamic "create_table_default_permission" {
    # not setting permissions by default; add here if you want specific principals/permissions
    for_each = []
    content {
      permissions = []
      principal {
        data_lake_principal_identifier = ""
      }
    }
  }


}



