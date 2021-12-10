# creating the API gateway, depends on VPC-Link
resource "aws_apigatewayv2_api" "app" {
  name          = "app-http-api"
  protocol_type = "HTTP"

  depends_on = [
    aws_apigatewayv2_vpc_link.nginx-vpc-link
  ]
}

# Creating default stage
resource "aws_apigatewayv2_stage" "default" {
  api_id = aws_apigatewayv2_api.app.id
  name   = "$default"
  auto_deploy = true
}

# Creating api-gateway route
resource "aws_apigatewayv2_route" "app-route" {
  api_id    = aws_apigatewayv2_api.app.id
  route_key = "$default"
  target = "integrations/${aws_apigatewayv2_integration.app-integration.id}"
  depends_on = [aws_apigatewayv2_integration.app-integration]
}

# Creating api-gateway route stage
resource "aws_apigatewayv2_integration" "app-integration" {
  api_id           = aws_apigatewayv2_api.app.id
  description      = "Private load balancer"
  integration_type = "HTTP_PROXY"
  integration_uri  = aws_lb_listener.nginx-alb-listner.arn
  integration_method = "ANY"
  connection_type    = "VPC_LINK"
  connection_id      = aws_apigatewayv2_vpc_link.nginx-vpc-link.id
}