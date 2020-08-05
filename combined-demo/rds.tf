# resource "aws_db_subnet_group" "tf-poc-db-subnet-group" {
#   name        = "mariadb-subnet"
#   description = "TF POC DB Subnet Group"
#   subnet_ids  = [aws_subnet.tf-private-subnet-1.id, aws_subnet.tf-private-subnet-2.id]
# }

# resource "aws_db_parameter_group" "tf-poc-mariadb-param" {
#   name        = "tf-poc-mariadb-param"
#   family      = "mariadb10.4" # https://ap-southeast-1.console.aws.amazon.com/rds/home?region=ap-southeast-1#parameter-groups:
#   description = "MariaDB parameter group"

#   parameter {
#     name  = "max_allowed_packet"
#     value = "16777216"
#   }
# }

# resource "aws_db_instance" "tf-poc-mariadb" {
#   allocated_storage      = 100 # 100 GiB of storage, give us more IOPS than a lower number
#   engine                 = "mariadb"
#   engine_version         = "10.4"
#   instance_class         = "db.t2.small"
#   identifier             = "mariadb"
#   name                   = "mariadb"
#   username               = var.AWS_RDS_USER
#   password               = var.AWS_RDS_PASS
#   db_subnet_group_name   = aws_db_subnet_group.tf-poc-db-subnet-group.name
#   parameter_group_name   = aws_db_parameter_group.tf-poc-mariadb-param.name
#   multi_az               = false
#   vpc_security_group_ids = [aws_security_group.tf-poc-db-sg.id]
#   skip_final_snapshot    = true # tmp fix, teardown throw DB Instance FinalSnapshotIdentifier is required when a final snapshot is required
# }

# output "rds" {
#   value = aws_db_instance.tf-poc-mariadb.endpoint
# }
