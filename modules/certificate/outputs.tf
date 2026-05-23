output "id" {
  value       = aws_acm_certificate.main.id
  description = "Id do certificado"
}

output "arn" {
  value       = aws_acm_certificate.main.arn
  description = "ARN do certificado"
}

output "domain_validation_options" {
  value       = aws_acm_certificate.main.domain_validation_options
  description = "Opcoes de validacao pro dominio do certificado"
}
