output "public_ip" {
  description = "Public IP address of the EC2 instance"
  value       = aws_instance.web.public_ip
}

output "subnet_id" {
  description = "ID of the subnet where the EC2 instance is launched"
  value       = aws_instance.web.subnet_id
}

output "vpc_id" {
  description = "ID of the VPC"
  value       = aws_vpc.main.id
}