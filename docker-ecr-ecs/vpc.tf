resource "aws_vpc" "tf-ecs-vpc" {
  cidr_block           = "10.0.0.0/16"
  instance_tenancy     = "default"
  enable_dns_support   = true
  enable_dns_hostnames = false
  enable_classiclink   = false

  tags = {
    Name = "tf-ecs-vpc"
  }
}

resource "aws_subnet" "tf-ecs-public-subnet1" {
  vpc_id                  = aws_vpc.tf-ecs-vpc.id
  cidr_block              = "10.0.1.0/24"
  map_public_ip_on_launch = true
  availability_zone       = "ap-southeast-1a"

  tags = {
    Name = "tf-ecs-public-subnet1"
  }
}

resource "aws_subnet" "tf-ecs-public-subnet2" {
  vpc_id                  = aws_vpc.tf-ecs-vpc.id
  cidr_block              = "10.0.2.0/24"
  map_public_ip_on_launch = true
  availability_zone       = "ap-southeast-1b"

  tags = {
    Name = "tf-ecs-public-subnet2"
  }
}

resource "aws_subnet" "tf-ecs-public-subnet3" {
  vpc_id                  = aws_vpc.tf-ecs-vpc.id
  cidr_block              = "10.0.3.0/24"
  map_public_ip_on_launch = true
  availability_zone       = "ap-southeast-1c"

  tags = {
    Name = "tf-ecs-public-subnet3"
  }
}


# Internet GW
resource "aws_internet_gateway" "tf-ecs-gw" {
  vpc_id = aws_vpc.tf-ecs-vpc.id

  tags = {
    Name = "tf-ecs-gp"
  }
}

# route table
resource "aws_route_table" "tf-ecs-public-route" {
  vpc_id = aws_vpc.tf-ecs-vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.tf-ecs-gw.id
  }

  tags = {
    Name = "tf-ecs-public-route"
  }
}

# route table association
resource "aws_route_table_association" "tf-ecs-public-route-association-1" {
  subnet_id      = aws_subnet.tf-ecs-public-subnet1.id
  route_table_id = aws_route_table.tf-ecs-public-route.id
}

# route table association
resource "aws_route_table_association" "tf-ecs-public-route-association-2" {
  subnet_id      = aws_subnet.tf-ecs-public-subnet2.id
  route_table_id = aws_route_table.tf-ecs-public-route.id
}
# route table association
resource "aws_route_table_association" "tf-ecs-public-route-association-3" {
  subnet_id      = aws_subnet.tf-ecs-public-subnet3.id
  route_table_id = aws_route_table.tf-ecs-public-route.id
}
