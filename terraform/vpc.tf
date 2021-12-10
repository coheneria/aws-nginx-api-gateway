# Creating VPC
resource "aws_vpc" "api-gateway-vpc" {
  cidr_block = "10.0.0.0/16"
  tags = {
    Name = "api-gateway-vpc"
  }
}

resource "aws_subnet" "public-subnet-01" {
  vpc_id     = aws_vpc.api-gateway-vpc.id
  cidr_block = "10.0.1.0/24"
  availability_zone = "us-east-1a"
  map_public_ip_on_launch = true
  tags = {
    Name = "public-subnet-1a"
    Tier = "Public"
  }
}

# Creating 2 private + public subnets for multiple availability zones
resource "aws_subnet" "public-subnet-02" {
  vpc_id     = aws_vpc.api-gateway-vpc.id
  cidr_block = "10.0.16.0/24"
  availability_zone = "us-east-1b"
  map_public_ip_on_launch = true
  tags = {
    Name = "public-subnet-1b"
    Tier = "Public"
  }
}

resource "aws_subnet" "private-subnet-01" {
  vpc_id     = aws_vpc.api-gateway-vpc.id
  cidr_block = "10.0.32.0/24"
  availability_zone = "us-east-1a"
  tags = {
    Name = "private-subnet-1a"
    Tier = "Private"
  }
}

resource "aws_subnet" "private-subnet-02" {
  vpc_id     = aws_vpc.api-gateway-vpc.id
  cidr_block = "10.0.64.0/24"
  availability_zone = "us-east-1b"
  tags = {
    Name = "private-subnet-1b"
    Tier = "Private"
  }
}

# Attach Internet gateway to our VPC
resource "aws_internet_gateway" "gw" {
  vpc_id = aws_vpc.api-gateway-vpc.id
  tags = {
    Name = "ig-getway"
  }
}

# Creating route tables
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

resource "aws_route_table_association" "public-route-association-01" {
  subnet_id      = aws_subnet.public-subnet-01.id
  route_table_id = aws_route_table.public-route-table.id
}

resource "aws_route_table_association" "public-route-association-02" {
  subnet_id      = aws_subnet.public-subnet-02.id
  route_table_id = aws_route_table.public-route-table.id
}