output "arn" {
  value       = aws_sns_topic.main.arn
  description = "ARN do topico SNS"
}

output "id" {
  value       = aws_sns_topic.main.id
  description = "Id do topico SNS"
}

output "name" {
  value       = aws_sns_topic.main.name
  description = "Nome do topico SNS"
}