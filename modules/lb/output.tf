output "gwlb_arn" {
  value = aws_lb.gwlb.arn
}

output "gwlb_dns_name" {
  value = aws_lb.gwlb.dns_name
}

output "gwlb_target_group_arn" {
  value = aws_lb_target_group.gwlb_tg.arn
}

output "gwlb_endpoints" {
  value = aws_vpc_endpoint.gwlb_endpoint[*].id
}

output "gwlb_service_name" {
  value = aws_vpc_endpoint_service.gwlb_service.service_name
}
