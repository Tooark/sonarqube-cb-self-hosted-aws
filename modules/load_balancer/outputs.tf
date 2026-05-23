output "arn" {
  value       = aws_lb.main.arn
  description = "ARN do Load balancer"
}

output "dns_name" {
  value       = aws_lb.main.dns_name
  description = "Nome do dns Load Balancer"
}