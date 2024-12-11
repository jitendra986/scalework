terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.16"
    }
  }

  required_version = ">= 1.2.0"
}

# Provider configuration
provider "aws" {
  region = var.region
}

# Create VPC
resource "aws_vpc" "main" {
  cidr_block           = var.vpc_cidr
  enable_dns_hostnames = true

  tags = {
    Name = "MyVPC"
  }
}

# Create two subnets
resource "aws_subnet" "Subnet1" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = var.subnet1_cidr
  availability_zone = "eu-central-1a"

  tags = {
    Name = "Subnet1"
  }
}

resource "aws_subnet" "Subnet2" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = var.subnet2_cidr
  availability_zone = "eu-central-1b"

  tags = {
    Name = "Subnet2"
  }
}

# Create Internet Gateway
resource "aws_internet_gateway" "main" {
  vpc_id = aws_vpc.main.id
}

# Create Route Table
resource "aws_route_table" "route_table" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.main.id
  }

  tags = {
    Name = "PublicRouteTable"
  }
}

# Associate subnets with the route table
resource "aws_route_table_association" "subnet_association_1" {
  subnet_id      = aws_subnet.Subnet1.id
  route_table_id = aws_route_table.route_table.id
}

resource "aws_route_table_association" "subnet_association_2" {
  subnet_id      = aws_subnet.Subnet2.id
  route_table_id = aws_route_table.route_table.id
}


# Create Security Group
resource "aws_security_group" "allow_ssh" {
  name        = "allow_ssh"
  description = "Allow SSH inbound traffic"
  vpc_id      = aws_vpc.main.id

  ingress {
    description = "SSH from VPC"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "SSH from VPC"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "allow_ssh"
  }
}

# Create EC2 instance
#resource "aws_instance" "web" {
#  ami                    = var.ami_id
#  instance_type          = var.instance_type
#  subnet_id              = aws_subnet.main1.id
#  key_name               = var.key_name
#  vpc_security_group_ids = [aws_security_group.web_sg.id]

#  tags = {
#    Name = "WebServer"
#  }
#}

# Create EC2 instance
resource "aws_instance" "web" {
  ami                    = var.ami_id
  instance_type          = var.instance_type
  subnet_id              = aws_subnet.Subnet1.id
  vpc_security_group_ids = [aws_security_group.allow_ssh.id]

  tags = {
    Name = "Web Server"
  }
}


# Create S3 bucket for logs
resource "aws_s3_bucket" "logbucket" {
  bucket = "my-tf-log-bucket-12345"

  tags = {
    Name        = "My bucket"
    Environment = "Test"
  }
}

