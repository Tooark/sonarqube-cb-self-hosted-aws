output "ec2_host" {
  value       = module.ec2.dns_name
  description = "DNS da instância EC2"
}

output "ec2_ip" {
  value       = module.ec2.private_ip
  description = "IP privado da ec2"
}