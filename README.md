# Exploring Terraform

### Important Notes

- NEVER push secrets.tfvars to version control
- You can store Terraform states locally (.tfstate files) in version control but there could still be some sensitive information. (Better to store remotely in S3, etc.)
- You can also store Terraform states remotely in S3, consul, terraform enterprise using Terraform backend.

### Useful Commands

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

Destroy Terraform management infrastructures (Be very cautious as this will destroy everything)
`terraform destroy`

Rewrite Terraform configuration files to a canonical format and style
`terraform fmt`

Download and update modules
`terraform get`

Create a visual representation of a configuration or execution plan
`terraform graph`

Import will try and find the infrasture resource identified with ID and import the state into terraform.tfstate with resource id ADDRESS

```sh
terraform import [options] ADDERSS ID
e.g. terraform import aws_instance.<urInstanceVariableName> <aws instance id from aws console>
```

Output any of your resources. Using NAME will only output a specific resource
`terraform output [options] NAME`

Refresh the remote state. Can identify differences between state file and remote file
`terraform refresh`

Inspect Terraform state or plan
`terraform show`

Manually mark a resource for recreation
`terraform taint`

Manually unmark a resource as tainted
`terraform untaint`

Validates the Terraform files
`terraform validate`

Prints the Terraform version
`terraform version`

Workspace management
`terraform workspace`

### Useful links

#### EC2 Ubuntu AMI Locator

http://cloud-images.ubuntu.com/locator/ec2/
