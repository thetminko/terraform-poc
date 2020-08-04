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

variable "AWS_AMIS" {
  type = map(string)
  default = {
    ap-southeast-1 = "ami-0602ae7e6b9191aea"
  }
}

variable "AWS_INSTANCE_TYPE" {
  type    = string
  default = "t2.micro"
}

variable "INSTANCE_USERNAME" {
  type    = string
  default = "ec2-user"
}

variable "PATH_TO_PUBLIC_KEY" {
  type    = string
  default = "../id_rsa.pub"
}

variable "PATH_TO_PRIVATE_KEY" {
  type    = string
  default = "../id_rsa"
}
