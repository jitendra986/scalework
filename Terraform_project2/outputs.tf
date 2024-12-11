output "vpc_id" {
  description = "ID of the VPC"
  value       = aws_vpc.main.id
}

output "subnet_ids1" {
  description = "ID of the subnet where the EC2 instance is launched"
  value       = aws_subnet.Subnet1.id
}

output "subnet_ids2" {
  description = "ID of the subnet where the EC2 instance is launched"
  value       = aws_subnet.Subnet2.id
}

output "ec2_public_ip" {
  description = "Public IP address of the EC2 instance"
  value       = aws_instance.web.public_ip
}