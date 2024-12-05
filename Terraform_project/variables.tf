variable "vpc_cidr_block" {
  description = "CIDR block for the VPC"
  type        = string
  default     = "10.0.0.0/16"
}

variable "subnet_cidr_blocks" {
  description = "CIDR blocks for subnets"
  type        = list(string)
  default     = ["10.0.1.0/24", "10.0.2.0/24"]
}

variable "ec2_instance_type" {
  description = "EC2 instance type"
  type        = string
  default     = "t3.micro"
}

variable "ami_id" {
  description = "AMI ID for EC2 instance"
  type        = string
  default     = "ami-0121de3d416d6f6a2" # Amazon Linux 2 AMI (HVM), SSD Volume Type
}

variable "key_pair_name" {
  description = "Key pair name for SSH access"
  type        = string
}

variable "s3_bucket_name" {
  description = "Name of the S3 bucket for logs"
  type        = string
}