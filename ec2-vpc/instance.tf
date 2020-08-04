resource "aws_key_pair" "tf-poc" {
  key_name   = "tf-poc"
  public_key = file(var.PATH_TO_PUBLIC_KEY)
}

resource "aws_instance" "tf-poc" {
  ami           = lookup(var.AWS_AMIS, var.AWS_REGION)
  instance_type = var.AWS_INSTANCE_TYPE

  # keypair for ssh
  key_name = aws_key_pair.tf-poc.key_name

  # vpc subnet 
  subnet_id = aws_subnet.tf-public-subnet-1.id

  # security group 
  vpc_security_group_ids = [aws_security_group.tf-poc-sg.id]

}
