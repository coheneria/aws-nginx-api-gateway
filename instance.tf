# Creating private instance on subnet-private that will contain nginx
resource "aws_instance" "nginx-server" {
  ami = var.AMI
  instance_type = "t2.micro"
  subnet_id = aws_subnet.private-subnet.id
  vpc_security_group_ids = ["${aws_security_group.nginx.id}"]
  tags = {
      Name = "nginx-server"
  }
}