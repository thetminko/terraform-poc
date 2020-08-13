To push docker to ecr
docker build -t <aws_account_id>.dkr.ecr.<region>.amazonaws.com/tf-poc-ecr:1> .

using default AWS credentials
aws ecr get-login-password --region <region> | docker login --username AWS --password-stdin <aws_account_id>.dkr.ecr.<region>.amazonaws.com

using AWS profile e.g. in ~/.aws/credentials
[terraform-poc]
aws_access_key_id = xxxxx
aws_secret_access_key = xxxxxxxx

export AWS_PROFILE="terraform-poc" && aws ecr get-login-password --region <region> | docker login --username AWS --password-stdin <aws_account_id>.dkr.ecr.<region>.amazonaws.com

docker push <aws_account_id>.dkr.ecr.<region>.amazonaws.com/tf-poc-ecr:1>