resource "aws_elb" "tf-poc-elb" {
  name = "tf-poc-elb"

  subnets         = [aws_subnet.tf-public-subnet-1.id]
  security_groups = [aws_security_group.tf-poc-sg.id]

  listener {
    instance_port     = 80
    instance_protocol = "http"
    lb_port           = 80
    lb_protocol       = "http"
  }

  health_check {
    healthy_threshold   = 2
    unhealthy_threshold = 2
    timeout             = 10 // 10 secs
    target              = "HTTP:80/"
    interval            = 30
  }

  cross_zone_load_balancing   = true
  connection_draining         = true
  connection_draining_timeout = 400

  tags = {
    "Name" = "tf-poc-elb"
  }
}
