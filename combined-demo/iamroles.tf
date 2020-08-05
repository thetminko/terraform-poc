# create new role
resource "aws_iam_role" "tf-ec2-s3-role" {
  name               = "tf-ec2-s3-role"
  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "ec2.amazonaws.com"
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
EOF
}

# create role policy
resource "aws_iam_role_policy" "tf-ec2-s3-role-policy" {
  name = "tf-ec2-s3-role-policy"
  role = aws_iam_role.tf-ec2-s3-role.id

  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Action": [
        "s3:*"
      ],
      "Resource": [
        "arn:aws:s3:::tf-poc-s3-123",
        "arn:aws:s3:::tf-poc-s3-123/*"
      ]
    }
  ]
}
  
EOF
}

# this will be attached to ec2
resource "aws_iam_instance_profile" "tf-ec2-s3-instance-profile" {
  name = "tf-ec2-s3-instance-profile"
  role = aws_iam_role.tf-ec2-s3-role.name
}
