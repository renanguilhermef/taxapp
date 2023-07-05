resource "aws_lb_target_group" "taxapp" {
  name     = "taxapp-lb-target-group"
  port     = 8080
  protocol = "TCP"
  vpc_id   = aws_vpc.taxapp.id

  health_check {
    enabled  = true
    protocol = "TCP"
  }
}

resource "aws_lb" "taxapp" {
  name               = "taxapp-network-lb"
  internal           = true
  load_balancer_type = "network"

  subnets = [
    aws_subnet.api-private-1a.id,
    aws_subnet.api-private-1b.id,
    aws_subnet.api-private-1c.id

  ]
}

resource "aws_lb_listener" "taxapp" {
  load_balancer_arn = aws_lb.taxapp.arn
  port              = "8080"
  protocol          = "TCP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.taxapp.arn
  }
}