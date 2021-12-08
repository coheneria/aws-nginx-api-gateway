data "aws_subnet_ids" "public-subnets" {
  vpc_id = aws_vpc.api-gateway-vpc.id

  tags = {
    Tier = "Public"
  }
    depends_on = [
    aws_vpc.api-gateway-vpc
  ]
}

resource "aws_apigatewayv2_vpc_link" "nginx-vpc-link" {
  name               = "nginx-vpc-link"
  security_group_ids = [aws_security_group.vpc-link-sg.id]
  subnet_ids         = data.aws_subnet_ids.public-subnets.ids

  tags = {
    Name = "nginx-vpc-link"
  }

  depends_on = [
    aws_lb.nginx-load-balancer
  ]
}