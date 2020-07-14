resource "aws_instance" "demo3" {
  ami           = lookup(var.AWS_AMIS, var.AWS_REGION)
  instance_type = var.AWS_INSTANCE_TYPE

  tags = {
    Name = "Demo 3"
  }

  # execute locally and write private ips of aws instance to a local file
  provisioner "local-exec" {
    command = "echo ${aws_instance.demo3.private_ip} >> private_ips.txt"
  }
}

# set ip variable using aws instance public ip value
# output the variable
output "ip" {
  value = aws_instance.demo3.public_ip
}
