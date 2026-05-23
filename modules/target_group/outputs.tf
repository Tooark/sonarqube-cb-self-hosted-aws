output "id" {
  value       = aws_lb_target_group.main.id
  description = "ID do target group"
}

output "name" {
  value       = aws_lb_target_group.main.name_prefix
  description = "Nome do target group"
}

output "arn" {
  value       = aws_lb_target_group.main.arn
  description = "ARN do target group"
}