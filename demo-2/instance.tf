# upload public key to aws
resource "aws_key_pair" "mykey" {
  key_name   = "mykey"
  public_key = file(var.PATH_TO_PUBLIC_KEY)
}

resource "aws_instance" "demo2" {
  ami           = lookup(var.AWS_AMIS, var.AWS_REGION)
  instance_type = var.AWS_INSTANCE_TYPE

  # tell instance to use keypair login
  key_name = aws_key_pair.mykey.key_name

  tags = {
    Name = "Demo 2"
  }

  # upload file to instance
  provisioner "file" {
    source      = "./script.sh"
    destination = "/tmp/script.sh"
  }

  # exceute script on instance
  provisioner "remote-exec" {
    inline = [
      "chmod +x /tmp/script.sh",
      "sudo /tmp/script.sh"
    ]
  }

  # tell how to login to instance
  connection {
    host        = self.public_ip
    user        = var.INSTANCE_USERNAME
    private_key = file(var.PATH_TO_PRIVATE_KEY)
  }

}
