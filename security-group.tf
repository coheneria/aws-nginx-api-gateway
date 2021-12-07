resource "aws_security_group" "nginx" {
  name        = "private-machine"
  description = "SG for Private Machine"
  vpc_id      = aws_vpc.api-gateway-vpc.id

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
    Name = "private-machine"
  }
}