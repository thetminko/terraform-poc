resource "aws_key_pair" "tf-poc" {
  key_name   = "tf-poc"
  public_key = file(var.PATH_TO_PUBLIC_KEY)
}

resource "aws_instance" "tf-poc" {
  ami               = data.aws_ami.amzlinux2.id
  availability_zone = aws_subnet.tf-public-subnet-1.availability_zone
  instance_type     = var.AWS_INSTANCE_TYPE

  # keypair for ssh
  key_name = aws_key_pair.tf-poc.key_name

  # vpc subnet 
  subnet_id = aws_subnet.tf-public-subnet-1.id

  # security group 
  vpc_security_group_ids = [aws_security_group.tf-poc-sg.id]

  # use static private ip
  private_ip = "10.0.1.4"

  # cloud init
  # user_data = data.template_cloud_init_config.tf-cloudinit.rendered

  # role
  iam_instance_profile = aws_iam_instance_profile.tf-ec2-s3-instance-profile.name

}


output "instance" {
  value = aws_instance.tf-poc.public_ip
}
