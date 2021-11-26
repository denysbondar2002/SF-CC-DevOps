variable "aws_region" {
  type = string
  default = "us-east-1"
}

variable "key_pair_name" {
  type = string
  default = "DevOpsLab"
}

variable "public_key_file" {
  type = string
  description = "Path to the file containing SSH public key"
}

variable "ec2_instance_type" {
  type = string
  default = "t2.micro"
}

variable "ami_owners" {
  type = list
  description = "List of the AMI owners"
  default = ["136693071363"]
}

variable "ami_most_recent" {
  type = bool
  description = "Using most recent AMI"
  default = true
}

variable "ami_filters" {
  type = any
  description = "AMI Filters"
  default = {
    name = ["debian*"]
    virtualization-type = ["hvm"]
    architecture = ["x86_64"]
  }
}

variable "sg_name" {
  type = string
  description = "Security Group's Name"
  default = "devops-task-SG"
}

variable "ingress_fw_rules" {
  type = any
  description = "Ingress Firewall Rules"
  default = []
}

variable "egress_fw_rules" {
  type = any
  description = "Egress Firewall Rules"
  default = []
}

variable "boot_disk_size" {
  type = number
  description = "Boot Disk Size"
  default = 15
}

variable "bootstrap_script_file" {
  type = string
  description = "File containing BootStrap Script"
  default = "nginx.sh"
}