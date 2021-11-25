terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.27"
    }
  }

  required_version = ">= 0.14.9"
}

variable "region" {
  type    = string
  default = "eu-west-3"
}

variable "instance_type" {
  type    = string
  default = "t2.micro"
}

variable "key_pair_name" {
  type    = string
  default = "terraform"
}

variable "path_to_pub_key" {
  type    = string
  default = "~/.ssh/for-personal-servers.pub"
}

provider "aws" {
  region = var.region
}

data "aws_ami" "ubuntu" {
  most_recent = true
  owners      = ["099720109477"]

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  filter {
    name   = "architecture"
    values = ["x86_64"]
  }
}

resource "aws_eip" "elastic_ip" {
  instance = aws_instance.web_instance.id
}

resource "aws_security_group" "web-server-SG" {
  name = "web-server-SG"

  ingress = [
    {
      description      = "HTTP"
      from_port        = 80
      to_port          = 80
      protocol         = "tcp"
      cidr_blocks      = ["0.0.0.0/0"]
      ipv6_cidr_blocks = []
      prefix_list_ids  = []
      security_groups  = []
      self             = false
    },
    {
      description      = "HTTP"
      from_port        = 443
      to_port          = 443
      protocol         = "tcp"
      cidr_blocks      = ["0.0.0.0/0"]
      ipv6_cidr_blocks = []
      prefix_list_ids  = []
      security_groups  = []
      self             = false
    },
    {
      description      = "SSH"
      from_port        = 22
      to_port          = 22
      protocol         = "tcp"
      cidr_blocks      = ["0.0.0.0/0"]
      ipv6_cidr_blocks = []
      prefix_list_ids  = []
      security_groups  = []
      self             = false
    },
    {
      description      = "ICMP"
      from_port        = 8
      to_port          = 0
      protocol         = "icmp"
      cidr_blocks      = ["0.0.0.0/0"]
      ipv6_cidr_blocks = []
      prefix_list_ids  = []
      security_groups  = []
      self             = false
    }
  ]

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = []
    prefix_list_ids  = []
    security_groups  = []
    self             = false
  }
}

resource "aws_key_pair" "global-key" {
  key_name   = var.key_pair_name
  public_key = file(var.path_to_pub_key)
}


resource "aws_instance" "web_instance" {
  ami           = data.aws_ami.ubuntu.id
  instance_type = var.instance_type

  vpc_security_group_ids = [aws_security_group.web-server-SG.id]

  key_name = aws_key_pair.global-key.id

  root_block_device {
    volume_size = 8
  }

  tags = {
    "Name" = "web-server"
  }
}
