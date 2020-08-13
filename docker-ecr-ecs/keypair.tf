resource "aws_key_pair" "tf-keypair" {
  key_name   = "tf-poc"
  public_key = file(var.PATH_TO_PUBLIC_KEY)
}
