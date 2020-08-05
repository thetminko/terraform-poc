

resource "aws_security_group" "tf-poc-sg" {
  name   = "tf-poc-sg"
  vpc_id = aws_vpc.tf-poc-1.id

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    description = "allow ssh from my ip only"
    cidr_blocks = ["${local.ifconfig_co_json.ip}/32"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    description = "allow all"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "tf-poc-sg"
  }
}

# resource "aws_security_group" "tf-poc-db-sg" {
#   name   = "tf-poc-db-sg"
#   vpc_id = aws_vpc.tf-poc-1.id

#   ingress {
#     from_port       = 3306
#     to_port         = 3306
#     protocol        = "tcp"
#     description     = "allow db access from ec2-instance"
#     security_groups = [aws_security_group.tf-poc-sg.id]
#   }

#   egress {
#     from_port   = 0
#     to_port     = 0
#     protocol    = "-1"
#     description = "allow all outgoing"
#     cidr_blocks = ["0.0.0.0/0"]
#   }

#   tags = {
#     Name = "tf-poc-db-sg"
#   }
# }

