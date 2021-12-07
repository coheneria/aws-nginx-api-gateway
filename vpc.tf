resource "aws_vpc" "api-gateway-vpc" {
  cidr_block = "10.0.0.0/16"
  tags = {
    Name = "api-gateway-vpc"
  }
}

resource "aws_subnet" "public-subnet" {
  vpc_id     = aws_vpc.api-gateway-vpc.id
  cidr_block = "10.0.1.0/24"
  availability_zone = "us-east-1a"
  map_public_ip_on_launch = true
  tags = {
    Name = "public-subnet-1A"
  }
}

resource "aws_subnet" "private-subnet" {
  vpc_id     = aws_vpc.api-gateway-vpc.id
  cidr_block = "10.0.16.0/24"
  availability_zone = "us-east-1a"
  tags = {
    Name = "private-subnet-1A"
  }
}

resource "aws_internet_gateway" "gw" {
  vpc_id = aws_vpc.api-gateway-vpc.id
  tags = {
    Name = "ig-getway"
  }
}

resource "aws_route_table" "public-route-table" {
  vpc_id       = aws_vpc.api-gateway-vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.gw.id
  }

  tags       = {
    Name     = "public-route-table"
  }
}

resource "aws_route_table_association" "public-route-association" {
  subnet_id      = aws_subnet.subnet-1.id
  route_table_id = aws_route_table.public-route-table.id
}