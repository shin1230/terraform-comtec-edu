terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 2.70"
    }
  }
}

provider "aws" {
  profile = "default"
  # region  = "ap-northeast-2"
}

resource "aws_vpc" "EDU-VPC" {
  cidr_block           = "10.0.0.0/16"
  enable_dns_hostnames = true

  tags = {
    Name    = "EDU-VPC"
  }

}

resource "aws_subnet" "public-subnet" {
  vpc_id = aws_vpc.EDU-VPC.id
  cidr_block = "10.0.1.0/24"

  tags = {
    Name = "public-subnet"
  }
}

resource "aws_network_interface" "foo" {
  subnet_id   = aws_subnet.public-subnet.id

  tags = {
    Name = "primary_network_interface"
  }
}

resource "aws_instance" "EC2-EDU" {
  ami = "ami-05b616430d239765b"
  instance_type = "t3.micro"

  network_interface {
    network_interface_id = aws_network_interface.foo.id
    device_index         = 0
  }

  tags = {
    Name = "EC2-EDU"
  }
}