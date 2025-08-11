resource "aws_acm_certificate" "example" {
  domain_name       = "chetan777.com"
  validation_method = "DNS"
}



