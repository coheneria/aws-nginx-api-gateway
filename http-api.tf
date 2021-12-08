resource "aws_apigatewayv2_api" "app" {
  name          = "app-http-api"
  protocol_type = "HTTP"

  depends_on = [
    aws_apigatewayv2_vpc_link.nginx-vpc-link.id
  ]
}

resource "aws_apigatewayv2_route" "app-route" {
  api_id    = aws_apigatewayv2_api.app.id
  route_key = "$default"
}

resource "aws_apigatewayv2_integration" "app-integration" {
  api_id           = aws_apigatewayv2_api.app.id
  description      = "Private load balancer"
  integration_type = "HTTP_PROXY"
  integration_uri  = aws_lb_listener.nginx-alb-listner
  integration_method = "ANY"
  connection_type    = "VPC_LINK"
  connection_id      = aws_apigatewayv2_vpc_link.nginx-vpc-link.id

  request_parameters = {
    "append:header.authforintegration" = "$context.authorizer.authorizerResponse"
    "overwrite:path"                   = "staticValueForIntegration"
  }

  response_parameters {
    status_code = 403
    mappings = {
      "append:header.auth" = "$context.authorizer.authorizerResponse"
    }
  }

  response_parameters {
    status_code = 200
    mappings = {
      "overwrite:statuscode" = "204"
    }
  }
}