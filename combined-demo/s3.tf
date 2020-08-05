resource "aws_s3_bucket" "tf-poc-s3-123" {
  bucket = "tf-poc-s3-123"
  acl    = "private"

  tags = {
    Name = "tf-poc-s3-123"
  }
}
