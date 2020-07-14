### Objective

This demo is on

- template provider
- create customized configuration files
- build templates based on variables from Terraform resource attributes (e.g public IP)
- can be used to create generic templates or cloud init configs

### Notes:

Before we execute, `terraform init`, make sure that S3 bucket is setup and `aws configure` has been executed and provided the credentials you want to use for Terraform to upload the states to S3.
