# Creating vpc-link security group
resource "aws_security_group" "vpc-link-sg" {
  name        = "vpc-link-sg"
  description = "Security Group for vpc-link"
  vpc_id      = aws_vpc.api-gateway-vpc.id

    ingress = [
    {
      description      = "HTTP"
      from_port        = 80
      to_port          = 80
      protocol         = "tcp"
      cidr_blocks      = ["0.0.0.0/0"]  
      ipv6_cidr_blocks = []
      prefix_list_ids = []
      security_groups = []
      self = false      
    }
  ]

  egress = [
    {
      description      = "for all outgoing traffics"
      from_port        = 0
      to_port          = 0
      protocol         = "-1"
      cidr_blocks      = ["0.0.0.0/0"]
      ipv6_cidr_blocks = ["::/0"]
      prefix_list_ids = []
      security_groups = []
      self = false
    }
  ]
  tags = {
    Name = "vpc-link-sg"
  }
}

# Creating Application Load Balancer security group
resource "aws_security_group" "alb-sg" {
  name        = "alb-security-group"
  description = "SG for alb"
  vpc_id      = aws_vpc.api-gateway-vpc.id

    ingress = [
    {
      description      = "HTTP"
      from_port        = 80
      to_port          = 80
      protocol         = "tcp"
      cidr_blocks      = []  
      ipv6_cidr_blocks = []
      prefix_list_ids = []
      security_groups = [aws_security_group.vpc-link-sg.id]
      self = false      
    },
  ]

  egress = [
    {
      description      = "for all outgoing traffics"
      from_port        = 0
      to_port          = 0
      protocol         = "-1"
      cidr_blocks      = ["0.0.0.0/0"]
      ipv6_cidr_blocks = ["::/0"]
      prefix_list_ids = []
      security_groups = []
      self = false
    }
  ]

  tags = {
    Name = "alb-security-group"
  }

  depends_on = [
    aws_security_group.vpc-link-sg
  ]
}

# Creating instance security group
resource "aws_security_group" "ec2-sg" {
  name        = "ec2-sg"
  description = "SG for ec2"
  vpc_id      = aws_vpc.api-gateway-vpc.id

    ingress = [
    {
      description      = "HTTP"
      from_port        = 80
      to_port          = 80
      protocol         = "tcp"
      cidr_blocks      = []  
      ipv6_cidr_blocks = []
      prefix_list_ids = []
      security_groups = [aws_security_group.alb-sg.id]
      self = false      
    }
  ]

  egress = [
    {
      description      = "for all outgoing traffics"
      from_port        = 0
      to_port          = 0
      protocol         = "-1"
      cidr_blocks      = ["0.0.0.0/0"]
      ipv6_cidr_blocks = ["::/0"]
      prefix_list_ids = []
      security_groups = []
      self = false
    }
  ]

  tags = {
    Name = "ec2-sg"
  }
  depends_on = [
    aws_security_group.alb-sg
  ]
}