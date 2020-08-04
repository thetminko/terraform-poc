resource "aws_eip" "tf-private-nat-eip" {
  vpc = true
}

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

# route table association to private subnets to go out to internet
resource "aws_route_table_association" "tf-route-private-2" {
  subnet_id      = aws_subnet.tf-private-subnet-2.id
  route_table_id = aws_route_table.tf-poc-private-route.id
}

# route table association to private subnets to go out to internet
resource "aws_route_table_association" "tf-route-private-3" {
  subnet_id      = aws_subnet.tf-private-subnet-3.id
  route_table_id = aws_route_table.tf-poc-private-route.id
}
