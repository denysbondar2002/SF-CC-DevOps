
This configuration setup an EC2 Instance

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