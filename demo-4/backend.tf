# Upload Terraform state to remote S3
terraform {
  backend "s3" {
    bucket = "terraform-tfstate-f1add"
    key    = "terraform/demo4"
    region = "ap-southeast-1"
  }
}
