# Searching only for subnets with tag:Tier value:Public
data "aws_subnet_ids" "public-subnets" {
  vpc_id = aws_vpc.api-gateway-vpc.id
  filter {
    name = "tag:Tier"
    values = ["Public"]
  }
    depends_on = [
    aws_subnet.public-subnet-01,
    aws_subnet.public-subnet-02
  ]
}

# Creating VPC-Link
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