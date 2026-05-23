output "name" {
  description = "The name of the key pair"
  value       = aws_key_pair.main.key_name
}

output "arn" {
  value       = aws_key_pair.main.arn
  description = "ARN da Key Pair"
}

output "id" {
  value       = aws_key_pair.main.id
  description = "ID da Key Pair"
}