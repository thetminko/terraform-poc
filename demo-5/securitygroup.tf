data "aws_ip_ranges" "ap-southeast-1-ec2s" {
  regions  = ["ap-southeast-1"]
  services = ["ec2"]
}

resource "aws_security_group" "from-ap-southeast-1-sg" {
  ingress {
    from_port   = "80"
    to_port     = "80"
    protocol    = "tcp"
    cidr_blocks = data.aws_ip_ranges.ap-southeast-1-ec2s.cidr_blocks
  }

  tags = {
    CreateDate = data.aws_ip_ranges.ap-southeast-1-ec2s.create_date
    SyncToken  = data.aws_ip_ranges.ap-southeast-1-ec2s.sync_token
  }
}
