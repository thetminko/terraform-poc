
# resource "aws_iam_group" "tf-group" {
#   name = "tf-group"
# }

# # custom policy
# resource "aws_iam_policy" "tf-group-policy" {
#   name   = "tf-group-policy"
#   policy = <<EOF
# {
#   "Version": "2012-10-17",
#   "Statement": [
#     {
#       "Action": [
#         "ec2:Describe*"
#       ],
#       "Effect": "Allow",
#       "Resource": "*"
#     }
#   ]
# }
# EOF
# }

# resource "aws_iam_group_policy_attachment" "tf-group-policy-attachment" {
#   group      = aws_iam_group.tf-group.name
#   policy_arn = "arn:aws:iam::aws:policy/AdministratorAccess"
# }

# resource "aws_iam_group_policy_attachment" "tf-group-policy-attachment-2" {
#   group      = aws_iam_group.tf-group.name
#   policy_arn = aws_iam_policy.tf-group-policy.arn
# }

# resource "aws_iam_user" "tf-user" {
#   name = "tf-user"
# }

# resource "aws_iam_group_membership" "tf-group-user" {
#   name  = "tf-group-user"
#   users = [aws_iam_user.tf-user.name]
#   group = aws_iam_group.tf-group.name
# }
