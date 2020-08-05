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

# internet gateway
resource "aws_internet_gateway" "tf-poc-ig" {
  vpc_id = aws_vpc.tf-poc-1.id

  tags = {
    Name = "tf-poc-ig"
  }
}


# route table
resource "aws_route_table" "tf-poc-route" {
  vpc_id = aws_vpc.tf-poc-1.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.tf-poc-ig.id
  }

  tags = {
    Name = "tf-poc-route"
  }
}

#route table associate to public subnet
resource "aws_route_table_association" "tf-poc-route-asso" {
  route_table_id = aws_route_table.tf-poc-route.id
  subnet_id      = aws_subnet.tf-public-subnet-1.id
}


# private subnets
resource "aws_subnet" "tf-private-subnet-1" {
  vpc_id                  = aws_vpc.tf-poc-1.id
  cidr_block              = "10.0.2.0/24"
  map_public_ip_on_launch = false
  availability_zone       = "ap-southeast-1a"

  tags = {
    Name = "tf-private-subnet-1"
  }
}

resource "aws_subnet" "tf-private-subnet-2" {
  vpc_id                  = aws_vpc.tf-poc-1.id
  cidr_block              = "10.0.3.0/24"
  map_public_ip_on_launch = false
  availability_zone       = "ap-southeast-1b"

  tags = {
    Name = "tf-private-subnet-2"
  }
}

# for private subnet to go out to internet
resource "aws_eip" "tf-private-nat-eip" {
  vpc = true
}

# nat gateway in public subnet
resource "aws_nat_gateway" "tf-private-nat-gw" {
  allocation_id = aws_eip.tf-private-nat-eip.id
  subnet_id     = aws_subnet.tf-public-subnet-1.id
  depends_on    = [aws_internet_gateway.tf-poc-ig]
}

# route table
resource "aws_route_table" "tf-poc-private-route" {
  vpc_id = aws_vpc.tf-poc-1.id

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.tf-private-nat-gw.id
  }

  tags = {
    Name        = "tf-poc-private-route"
    Description = "For Terraform POC"
  }
}

# route table association to private subnets to go out to internet
resource "aws_route_table_association" "tf-route-private-1" {
  subnet_id      = aws_subnet.tf-private-subnet-1.id
  route_table_id = aws_route_table.tf-poc-private-route.id
}

resource "aws_route_table_association" "tf-route-private-2" {
  subnet_id      = aws_subnet.tf-private-subnet-2.id
  route_table_id = aws_route_table.tf-poc-private-route.id
}
