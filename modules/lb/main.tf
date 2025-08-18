# Gateway Load Balancer
resource "aws_lb" "gwlb" {
  name               = var.name
  load_balancer_type = "gateway"
  subnets            = var.endpoint_subnet_ids
  enable_deletion_protection = false

  tags = merge(var.tags, { Name = var.name })
}

# Target Group for appliances
resource "aws_lb_target_group" "gwlb_tg" {
  name        = "${var.name}-tg"
  port        = 6081
  protocol    = "GENEVE"
  vpc_id      = var.vpc_id
  target_type = "ip"

  health_check {
    protocol = "TCP"
  }

  tags = merge(var.tags, { Name = "${var.name}-tg" })
}

# Listener
resource "aws_lb_listener" "gwlb_listener" {
  load_balancer_arn = aws_lb.gwlb.arn
  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.gwlb_tg.arn
  }
}

# Endpoint Service for GWLB
resource "aws_vpc_endpoint_service" "gwlb_service" {
  acceptance_required        = false
  gateway_load_balancer_arns = [aws_lb.gwlb.arn]

  tags = merge(var.tags, { Name = "${var.name}-service" })
}

# Two GWLB Endpoints (one per subnet)
resource "aws_vpc_endpoint" "gwlb_endpoint" {
  count               = 2
  vpc_id              = var.vpc_id
  service_name        = aws_vpc_endpoint_service.gwlb_service.service_name
  vpc_endpoint_type   = "GatewayLoadBalancer"
  subnet_ids          = [element(var.endpoint_subnet_ids, count.index)]

  tags = merge(var.tags, { Name = "${var.name}-endpoint-${count.index + 1}" })
}
