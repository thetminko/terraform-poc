resource "aws_instance" "Demo 1" {
  ami           = lookup(var.AWS_AMIS, var.AWS_REGION)
  instance_type = var.AWS_INSTANCE_TYPE

  tags = {
    Name = "Demo 1"
  }
}
