output "id" {
  value       = aws_instance.main.id
  description = "Id da ec2"
}

output "arn" {
  value       = aws_instance.main.arn
  description = "ARN da ec2"
}

output "name" {
  value       = aws_instance.main.tags["Name"]
  description = "Nome da Ec2 na tag 'Name'"
}

output "dns_name" {
  value       = aws_instance.main.private_dns
  description = "DNS privado da ec2"
}

output "subnet_id" {
  value       = aws_instance.main.subnet_id
  description = "ID da Subnet onde a ec2 está"
}

output "security_group_id" {
  value       = aws_instance.main.security_groups
  description = "Ids dos Security Groups da ec2"
}

output "availability_zone" {
  value       = aws_instance.main.availability_zone
  description = "Zona de disponibilidade da ec2"
}
output "private_ip" {
  value       = aws_instance.main.private_ip
  description = "Ip privado da ec2"
}

output "public_ip" {
  value       = aws_instance.main.public_ip
  description = "Ip publico"
}

output "public_dns_name" {
  value       = aws_instance.main.public_dns
  description = "DNS publico da ec2"
}

output "private_dns_name" {
  value       = aws_instance.main.private_dns
  description = "DNS privado da ec2"
}

output "instance_type" {
  value       = aws_instance.main.instance_type
  description = "Tipo de instancia ec2"
}

output "ami_id" {
  value       = aws_instance.main.ami
  description = "ID da AMI ec2"
}