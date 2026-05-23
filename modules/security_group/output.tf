output "security_group_id" {
  value       = aws_security_group.main.id
  description = "Id do Security Group"
}

output "name" {
  value       = aws_security_group.main.name
  description = "Nome do Security Group"
}