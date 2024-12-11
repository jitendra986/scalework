# AWS region
variable "region" {
  description = "AWS region for resources"
  default     = "eu-central-1"
}

# VPC CIDR block 
variable "vpc_cidr" {
  description = "CIDR block for the VPC"
  type        = string
  default     = "10.0.0.0/16"
}

# Subnet CIDR blocks
variable "subnet1_cidr" {
  type    = string
  default = "10.0.1.0/24"
}

variable "subnet2_cidr" {
  type    = string
  default = "10.0.2.0/24"
}

# EC2 instance instance_type
variable "instance_type" {
  description = "EC2 instance type"
  type        = string
  default     = "t3.micro"
}


# AMI id
variable "ami_id" {
  description = "AMI ID for the EC2 instance"
  type        = string
  default     = "ami-00dc61b35bec09b72" # Amazon Linux 2 AMI
}

variable "key_pair_name" {
  description = "Key pair name for SSH access"
  type        = string
}

variable "s3_bucket_name" {
  description = "Name of the S3 bucket for logs"
  type        = string
}