# public vpc
resource "aws_vpc" "tf-poc-1" {
  cidr_block           = "10.0.0.0/16" # only required
  instance_tenancy     = "default"     # optional, by default value is "default"
  enable_dns_support   = true          # optional
  enable_dns_hostnames = true          # optional
  enable_classiclink   = false         # optional

  tags = {
    Name        = "tf-poc-1"
    Description = "Creating VPC using Terrform"
  }
}

# public subnets: 1
resource "aws_subnet" "tf-public-subnet-1" {
  vpc_id                  = aws_vpc.tf-poc-1.id
  cidr_block              = "10.0.1.0/24"
  map_public_ip_on_launch = true

  tags = {
    Name        = "tf-public-subnet-1"
    Description = "For Terraform POC"
  }
}

# public subnets: 2
resource "aws_subnet" "tf-public-subnet-2" {
  vpc_id                  = aws_vpc.tf-poc-1.id
  cidr_block              = "10.0.2.0/24"
  map_public_ip_on_launch = true

  tags = {
    Name        = "tf-public-subnet-2"
    Description = "For Terraform POC"
  }
}

# public subnets: 3
resource "aws_subnet" "tf-public-subnet-3" {
  vpc_id                  = aws_vpc.tf-poc-1.id
  cidr_block              = "10.0.3.0/24"
  map_public_ip_on_launch = true

  tags = {
    Name        = "tf-public-subnet-3"
    Description = "For Terraform POC"
  }
}

# private subnets: 1
resource "aws_subnet" "tf-private-subnet-1" {
  vpc_id                  = aws_vpc.tf-poc-1.id
  cidr_block              = "10.0.4.0/24"
  map_public_ip_on_launch = false # private subnet

  tags = {
    Name        = "tf-private-subnet-1"
    Description = "For Terraform POC"
  }
}

# private subnets: 2
resource "aws_subnet" "tf-private-subnet-2" {
  vpc_id                  = aws_vpc.tf-poc-1.id
  cidr_block              = "10.0.5.0/24"
  map_public_ip_on_launch = false # private subnet

  tags = {
    Name        = "tf-private-subnet-2"
    Description = "For Terraform POC"
  }
}

# private subnets: 2
resource "aws_subnet" "tf-private-subnet-3" {
  vpc_id                  = aws_vpc.tf-poc-1.id
  cidr_block              = "10.0.6.0/24"
  map_public_ip_on_launch = false # private subnet

  tags = {
    Name        = "tf-private-subnet-3"
    Description = "For Terraform POC"
  }
}

# internet gateway for public subnets
resource "aws_internet_gateway" "tf-poc-ig" {
  vpc_id = aws_vpc.tf-poc-1.id

  tags = {
    Name        = "tf-poc-ig"
    Description = "For Terraform POC"
  }
}

# route table
resource "aws_route_table" "tf-poc-public-route" {
  vpc_id = aws_vpc.tf-poc-1.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.tf-poc-ig.id
  }

  tags = {
    Name        = "tf-poc-public-route"
    Description = "For Terraform POC"
  }
}

# route table association to public subnets
resource "aws_route_table_association" "tf-route-public-1" {
  subnet_id      = aws_subnet.tf-public-subnet-1.id
  route_table_id = aws_route_table.tf-poc-public-route.id
}

# route table association to public subnets
resource "aws_route_table_association" "tf-route-public-2" {
  subnet_id      = aws_subnet.tf-public-subnet-2.id
  route_table_id = aws_route_table.tf-poc-public-route.id
}

# route table association to public subnets
resource "aws_route_table_association" "tf-route-public-3" {
  subnet_id      = aws_subnet.tf-public-subnet-3.id
  route_table_id = aws_route_table.tf-poc-public-route.id
}
