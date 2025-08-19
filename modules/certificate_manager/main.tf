resource "aws_acm_certificate" "example" {
  domain_name       = var.domain_name
  validation_method = var.validation_method
  lifecycle {
    create_before_destroy = true
  }
}



