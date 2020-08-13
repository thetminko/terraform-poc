variable "AWS_ACCESS_KEY" {
  type = string
}

variable "AWS_SECRET_KEY" {
  type = string
}

variable "AWS_REGION" {
  type    = string
  default = "ap-southeast-1"
}

variable "PATH_TO_PUBLIC_KEY" {
  default = "../id_rsa.pub"
}

