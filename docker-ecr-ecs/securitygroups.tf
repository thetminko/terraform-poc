# security group for elb
resource "aws_security_group" "tf-elb-sg" {
  name        = "tf-elb-sg"
  description = "Allow HTTP from anywhere"
  vpc_id      = aws_vpc.tf-ecs-vpc.id

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "tf-elb-sg"
  }
}

# security group for ecs ec2
resource "aws_security_group" "tf-ecs-sg" {
  name        = "tf-ecs-sg"
  description = "Allow ssh only from my public ip and allow HTTP traffic only from ELB"
  vpc_id      = aws_vpc.tf-ecs-vpc.id

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["${local.ifconfig_co_json.ip}/32"]
  }

  ingress {
    from_port       = 3000
    to_port         = 3000
    protocol        = "tcp"
    security_groups = [aws_security_group.tf-elb-sg.id]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "tf-ecs-sg"
  }
}
