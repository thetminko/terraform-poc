resource "aws_ecr_repository" "tf-poc-ecr" {
  name = "tf-poc-ecr"
}

output "tf-poc-ecr-url" {
  value = aws_ecr_repository.tf-poc-ecr.repository_url
}
