resource "aws_s3_bucket" "this" {
  bucket = var.bucket_name
}

resource "aws_glue_catalog_database" "this" {
  name = var.database_name
}

resource "aws_athena_workgroup" "this" {
  name = "custom-athena-workgroup"

  configuration {
    result_configuration {
      output_location = "s3://${aws_s3_bucket.this.bucket}/athena-output/"
    }
  }
}
