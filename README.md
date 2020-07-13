# Exploring Terraform

### Important Notes

- NEVER push secrets.tfvars to version control
- You can store Terraform states (.tfstate files) in version control
- You can also store Terraform states remotely in S3, consul, terraform enterprise using Terraform backend.

Open Terraform console:

`terraform console`

Init Terrafrom:

`terraform init`

Plan only without executing:

`terraform plan -var-file secrets.tfvars`

Plan the output file and use this file to apply later:

`terraform plan -var-file secrets.tfvars -out changes.terraform`

Apply changes shorthand:

`terraform apply -var-file secrets.tfvars`

Apply changes using output plan file. When using saved plan, no need to supply variables again:

`terraform apply changes.terraform`

### Useful links

#### EC2 Ubuntu AMI Locator

http://cloud-images.ubuntu.com/locator/ec2/
