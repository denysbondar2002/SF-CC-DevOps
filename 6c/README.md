# Terraform module to deploy a VM running Nginx Web server

## This configuration setup an EC2 Instance

To run this configuration you need to do these steps: 
1. Install terraform
2. Chance dir to '6c'
4. Run the command:
```bash
terraform init
```
5. Export these required variables
5.1) AWS_ACCESS_KEY_ID - your IAM access key
5.2) AWS_SECRET_ACCESS_KEY - your IAM secret key

6. (Optional)
6.1) TF_VAR_aws_region - AWS region
6.2) TF_VAR_key_pair_name - Name the new ssh key pair
6.3) TF_VAR_public_key - Public part of ssh key
6.4) TF_VAR_ec2_instance_type=

7. To setup an infrastructure, run the command:
```bash
terraform plan
terraform apply
```
8. To destroy an infrastructure setup above run this command:
```bash
terraform destroy
```

## Refactoring
### Creating conventional module structure
Putting all code in one file is absolutely okay when you're getting familiar with Terraform. However, it is strongly recommended to split the code logically into the following files:

* `main.tf` - create all resources
* `provider.tf` - contains Provider's configuration. It's not changed as much as other parts of code, so it's better to keep it in a separate file
* `data.tf` - contains data sources
* `variables.tf` - contains declarations of variables used in `main.tf`
* `outputs.tf` - contains outputs from the resources created in `main.tf`

* `terraform.tfvars` - the values of variables are specified here. They are usually project-specific, so it's better to add it to `.gitignore`. You should try keeping Terraform code as generic as possible, so it can be easily re-used by other people.
* `terraform.tfvars.example` - this one contains some examples on how to specify the variables, some comments, etc. Store it in the repo, so everyone can use it as an example

* `firewall.tf` can be used to separate firewall settings

### Getting rid of hard-coded parameters
TBD

### Data source - Dynamic block
TBD

### Firewall Rules - Dynamic block
TDB

### Bootstrap script
TBD