output "name" {
  value       = aws_ssm_association.install_cw_agent.name
  description = "Nome do Run Command no SystemsManager"
}

output "id" {
  value       = aws_ssm_association.install_cw_agent.id
  description = "Id do Run Command no SystemsManager "
}

output "arn" {
  value       = aws_ssm_association.install_cw_agent.arn
  description = "ARN do Run Command no SystemsManager"
}