resource "aws_lb_target_group" "instance-target-group" {
  health_check {
    interval            = 60
    path                = "/"
    protocol            = "HTTP"
    timeout             = 50
    healthy_threshold   = 2
    unhealthy_threshold = 8
  }

  name        = "instance-target-group"
  port        = 80
  protocol    = "HTTP"
  target_type = "instance"
  vpc_id      = aws_vpc.api-gateway-vpc.id
  depends_on = [
    aws_instance.nginx-server,
  ]
}

resource "aws_lb_target_group_attachment" "nginx-instance" {
  target_group_arn = aws_lb_target_group.instance-target-group.arn
  target_id        = "${aws_instance.nginx-server.id}"
  port= 80
}

resource "aws_lb" "nginx-load-balancer" {
  name     = "nginx-load-balancer"
  internal = true

  security_groups = [
    "${aws_security_group.alb-sg.id}",
  ]

  subnets = [
    "${aws_subnet.public-subnet-01.id}",
    "${aws_subnet.public-subnet-02.id}",
  ]

  tags = {
    Name = "nginx-load-balancer"
  }

  ip_address_type    = "ipv4"
  load_balancer_type = "application"
}

resource "aws_lb_listener" "nginx-alb-listner" {
  load_balancer_arn = "${aws_lb.nginx-load-balancer.arn}"
  port              = 80
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = "${aws_lb_target_group.instance-target-group.arn}"
  }
}