### Objective

This demo is on

- get latest amazon linux2 ami [instance.tf](./instance.tf) [getlatestami.tf](./getlatestami.tf)
- creating ec2-instances in custom VPC with public subnet [instance.tf](./instance.tf) [vpc.tf](./vpc.tf)
- using keypairs [instance.tf](./instance.tf)
- security group allow ssh from own ip [securitygroup.tf](./securitygroup.tf) [getpublicip.tf](./getpublicip.tf)
- attach ebs volumn to ec2 in vpc created from ec2-vpc tutorial [ebs.tf](./ebs.tf)
- use CloudInit to run scripts after instance is up [cloudinit.tf](./cloudinit.tf) [instance.tf](./instance.tf)
- assign static private ip to instances [instace.tf](./instance.tf)
- route53 (DNS records) [route53.tf](./route53.tf)
- RDS [rds.tf](./rds.tf)
- IAM User and Groups [iam.tf](./iam.tf)
- IAM User roles and EC-2 instance profile [iamroles.tf](./iamroles.tf)
- Autoscaling [autoscaling.tf](./autoscaling.tf) [autoscalingpolicy.tf](./autoscalingpolicy.tf) [sns.tf](./sns.tf) (We could use stress lib to simulate load on ec2 instances)
