# resource "aws_ebs_volume" "tf-poc-ebs" {
#   availability_zone = aws_subnet.tf-public-subnet-1.availability_zone
#   size              = 10    # in Gbs
#   encrypted         = true  # enable encryption
#   type              = "gp2" # default is also gp2

#   tags = {
#     Name = "tf-poc-ebs"
#   }
# }

# resource "aws_volume_attachment" "tf-poc-ebs-attach" {
#   device_name = var.AWS_EBS_DEVICE_NAME
#   instance_id = aws_instance.tf-poc.id
#   volume_id   = aws_ebs_volume.tf-poc-ebs.id
# }
