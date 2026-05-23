output "name" {
  value       = aws_secretsmanager_secret.secret.name
  description = "Nome do secret"
}

output "arn" {
  value       = aws_secretsmanager_secret.secret.arn
  description = "ARN do secret"
}

output "id" {
  value       = aws_secretsmanager_secret.secret.id
  description = "ID do secret"
}