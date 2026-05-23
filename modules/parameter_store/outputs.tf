output "name" {
  value       = aws_ssm_parameter.main.name
  description = "Nome do parametro"
}

output "value" {
  value       = aws_ssm_parameter.main.value
  description = "Valor armazenado no parametro"
}