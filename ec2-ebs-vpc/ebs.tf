resource "aws_ebs_volume" "tf-poc-ebs" {
  availability_zone = "ap-southeast-1a"
  size              = 10    # in Gbs
  encrypted         = true  # enable encryption
  type              = "gp2" # default is also gp2

  tags = {
    Name = "tf-poc-ebs"
  }
}

resource "aws_volume_attachment" "tf-poc-ebs-attach" {
  device_name = "/dev/xvdh"
  instance_id = aws_instance.tf-poc.id
  volume_id   = aws_ebs_volume.tf-poc-ebs.id
}
