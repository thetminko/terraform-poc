# load balance for ecs
resource "aws_alb" "tf-ecs-alb" {
  name               = "tf-ecs-alb"
  security_groups    = [aws_security_group.tf-elb-sg.id]
  load_balancer_type = "application"
  subnets            = [aws_subnet.tf-ecs-public-subnet1.id, aws_subnet.tf-ecs-public-subnet2.id, aws_subnet.tf-ecs-public-subnet3.id]
  tags = {
    Name = "tf-ecs-alb"
  }
}

resource "aws_alb_target_group" "tf-ecs-target-group" {
  name     = "tf-ecs-target-group"
  port     = "80"
  protocol = "HTTP"
  vpc_id   = aws_vpc.tf-ecs-vpc.id

  health_check {
    healthy_threshold   = "5"
    unhealthy_threshold = "2"
    interval            = "30"
    matcher             = "200"
    path                = "/"
    port                = "traffic-port"
    protocol            = "HTTP"
    timeout             = "5"
  }

  tags = {
    Name = "ecs-target-group"
  }
}

resource "aws_alb_listener" "tf-ecs-alb-listener" {
  load_balancer_arn = aws_alb.tf-ecs-alb.arn
  port              = "80"
  protocol          = "HTTP"

  depends_on = [aws_alb_target_group.tf-ecs-target-group]

  default_action {
    type             = "forward"
    target_group_arn = aws_alb_target_group.tf-ecs-target-group.arn
  }
}
