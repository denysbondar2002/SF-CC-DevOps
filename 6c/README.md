# Terraform module to deploy a VM running Nginx Web server

## This configuration sets up an EC2 Instance

To run this configuration, you need to do these steps: 
1. Install terraform
2. Change directory to '6c'
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

7. To set up an infrastructure, run the command:
```bash
terraform plan
terraform apply
```
8. To destroy an infrastructure setup above, run this command:
```bash
terraform destroy
```

## Refactoring
### Creating conventional module structure
Putting all code in one file is absolutely okay when you're getting familiar with Terraform. However, it is strongly recommended splitting the code logically into the following files:

* `main.tf` - create all resources
* `provider.tf` - contains Provider's configuration. It's not changed as much as other parts of code, so it's better to keep it in a separate file
* `data.tf` - contains data sources
* `variables.tf` - contains declarations of variables used in `main.tf`
* `outputs.tf` - contains outputs from the resources created in `main.tf`

* `terraform.tfvars` - the values of variables are specified here. They are usually project-specific, so it's better to add it to `.gitignore`. You should try keeping Terraform code as generic as possible, so it can be easily re-used by other people.
* `terraform.tfvars.example` - this one contains some examples on how to specify the variables, some comments, etc. Store it in the repo, so everyone can use it as an example

* `firewall.tf` can be used to separate firewall settings

### Getting rid of hard-coded parameters
All the input parameters, used by resources, data sources, providers and outputs, should come from:

* variables
```
resource "aws_key_pair" "tf-key" {
  key_name   = var.key_pair_name
  public_key = file(var.public_key_file)
}
```
* data sources
```
  ami           = data.aws_ami.debian.id
```

* other resources
```
resource "aws_eip" "elastic_ip" {
  instance = aws_instance.devops_task_6c.id
}
```

### Data source - Dynamic block
Data source `aws_ami` has repeatable content chunks, the `filter {}`. Which is when the `dymamic block` can help avoid copying and pasting similar chunks of code many times. Please take a look at the `data.tf` and `variables.tf` (variable `ami_filters`) to see how it works.

### Firewall Rules - Dynamic block
The same, `aws_security_group` resource contains `ingress {}` and `egress {}` structures, which are designed to repeat multiple times inside the resource. I've implemented the dynamic blocks there as well. Please review the `firewall.tf`, `variables.tf` and `terraform.tfvars.example` (variables `ingress_fw_rules` and `egress_fw_rules`).

>**Note:** for the `egress_fw_rules` variable in the `variables.tf` file I've specified a `default` parameter, which defines the egress firewall rule allowing all egress requests from the EC2 instance. That is required for the bootstrap script to be able to access package repository and install Nginx Web Server. On the other hand, the default value for the `ingress_fw_rules` is an empty list. Which basically means that all ingress requests, sent to EC2, will be rejected. That won't prevent the bootstrap script form installing Nginx, but the Web Server will not be accessible from the external network. Unless a set of ingress rules is defined in the `terraform.tfvars`. It can be done after the EC2 instance is provisioned.

### Bootstrap script
It's better to keep the bootstrap script in a separate file. Please take a look at the `user_data` parameter in the `aws_instance` resource (`main.tf`), `bootstrap_script_file` variable in the `variables.tf` file and the bootstrap script itself in the `nginx.sh` file.