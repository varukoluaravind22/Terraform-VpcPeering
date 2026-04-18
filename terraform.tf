terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 6.0"
    }
  }
}

# Configure the AWS Provider
provider "aws" {
  region = var.awsregion
  access_key = var.access_key
  secret_key = var.secret_key
}
resource "aws_vpc" "dev-vpc" {
  cidr_block       = var.vpc_cidr_block
  instance_tenancy = "default"

  tags = {
    Name = var.vpc_name
  }
}
resource "aws_subnet" "dev-pub-subnet" {
    vpc_id = aws_vpc.dev-vpc.id
    cidr_block = var.dev_pub_cidr_block
    map_public_ip_on_launch = var.public_ip_on
    tags = {
        Name = var.dev_pub_subnet_name
    }
}
resource "aws_subnet" "dev-pvt-subnet" {
  vpc_id = aws_vpc.dev-vpc.id
  cidr_block = var.dev_pvt_cidr_block
  tags = {
    Name = var.dev_pvt_subnet_name
  }
}
resource "aws_nat_gateway" "ngw" {
    connectivity_type = "private"
  subnet_id = aws_subnet.dev-pvt-subnet.id
}
resource "aws_internet_gateway" "gw" {
  vpc_id = aws_vpc.dev-vpc.id

  tags = {
    Name = var.internet_gateway_name
  }
}
resource "aws_route_table" "LMS_ROUTE_TABLE" {
  vpc_id = aws_vpc.dev-vpc.id
  route  {
    cidr_block = var.internetgateway_cidr
    gateway_id = aws_internet_gateway.gw.id 
    }
  tags = {
    Name = "${var.vpc_name}_ROUTE_TABLE"
  }
}

resource "aws_security_group" "dev-SG" {
    name = var.security_group_name
    description = "Security rules"
    ingress = [
        for port in var.Sercurity_group_ports:{
            description = "inbound rules"
            from_port = port
            to_port = port
            protocol = "tcp"
            cidr_blocks = ["0.0.0.0/0"]
            ipv6_cidr_blocks = []
            prefix_list_ids = []
            security_groups = []
            self = false
        }
    ]
    egress  {
        from_port = 0
        to_port = 0
        protocol = "-1"
        cidr_blocks = ["0.0.0.0/0"]
    }
}
