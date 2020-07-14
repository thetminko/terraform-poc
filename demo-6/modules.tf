resource "aws_key_pair" "mykey" {
  key_name   = "mykey"
  public_key = file(var.AWS_PATH_TO_PUBLIC_KEY)
}

module "consul" {
  source   = "github.com/wardviaene/terraform-consul-module.git"
  key_name = aws_key_pair.mykey.key_name
  key_path = var.AWS_PATH_TO_PUBLIC_KEY
  servers  = 1
  vpc_id   = "vpc-f218f696"
  subnets  = { 0 : "subnet-0ec2626a" }
}

output "consul-output" {
  value = module.consul.server_address
}
