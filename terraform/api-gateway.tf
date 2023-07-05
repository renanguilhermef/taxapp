resource "aws_apigatewayv2_api" "taxapp-api" {
  name          = "taxapp-api-gateway"
  protocol_type = "HTTP"
}

resource "aws_apigatewayv2_stage" "dev" {
  api_id = aws_apigatewayv2_api.taxapp-api.id

  name        = "dev"
  auto_deploy = true
}

resource "aws_apigatewayv2_vpc_link" "taxapp-api" {
  name               = "taxapp-api-vpc-link"
  security_group_ids = [aws_security_group.taxapp-api.id]
  subnet_ids = [
    aws_subnet.api-private-1a.id,
    aws_subnet.api-private-1b.id,
    aws_subnet.api-private-1c.id
  ]
}

resource "aws_apigatewayv2_integration" "taxapp-api" {
  api_id = aws_apigatewayv2_api.taxapp-api.id

  integration_uri    = aws_lb_listener.taxapp.arn
  integration_type   = "HTTP_PROXY"
  integration_method = "ANY"
  connection_type    = "VPC_LINK"
  connection_id      = aws_apigatewayv2_vpc_link.taxapp-api.id
}

resource "aws_apigatewayv2_route" "taxapp-api" {
  api_id = aws_apigatewayv2_api.taxapp-api.id

  route_key = "ANY /{proxy+}"
  target    = "integrations/${aws_apigatewayv2_integration.taxapp-api.id}"
}

output "test_url" {
  value = "${aws_apigatewayv2_stage.dev.invoke_url}/check"
}