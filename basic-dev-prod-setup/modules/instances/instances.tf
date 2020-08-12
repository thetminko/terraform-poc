variable "ENV" {}
variable "INSTANCE_TYPE" { default = "t2.micro" }
variable "PUBLIC_SUBNETS" {}
variable "VPC_ID" {}
variable "PUB_KEY" { default = "../../id_rsa.pub" }

resource "aws_key_pair" "tf-poc" {
  key_name   = "tf-poc"
  public_key = file(var.PUB_KEY)
}

resource "aws_instance" "instance" {
  ami           = data.aws_ami.amzlinux2.id
  instance_type = var.INSTANCE_TYPE

  # vpc subnet
  subnet_id = var.PUBLIC_SUBNETS[0]

  # security group
  vpc_security_group_ids = [aws_security_group.tf-allow-ssh.id]

  # public key for ec2
  key_name = aws_key_pair.tf-poc.key_name

  tags = {
    Name        = "tf-instance-${var.ENV}"
    Environment = var.ENV
  }
}

# instance ssh security group
resource "aws_security_group" "tf-allow-ssh" {
  name        = "tf-allow-ssh"
  description = "Allow ssh from my current public ip and allow all egress traffic"
  vpc_id      = var.VPC_ID

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "-1" # mosh use udp, so allow both tcp and udp
    cidr_blocks = ["${local.ifconfig_co_json.ip}/32"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name        = "tf-allow-ssh"
    Environment = var.ENV
  }
}
