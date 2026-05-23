output "user_name" {
  value       = aws_iam_user.service_user.name
  description = "Nome do usuario de servico IAM"
}

output "user_arn" {
  value       = aws_iam_user.service_user.arn
  description = "ARN do usuario de servico IAM"
}

output "user_credentials_name" {
  value       = module.secret.name
  description = "Nome das credenciais no Secret Manager"
}

output "user_credentials_arn" {
  value       = module.secret.arn
  description = "ARN das credenciais no Secret Manager"
}

output "user_credentials_id" {
  value       = module.secret.id
  description = "Id das credenciais no Secret Manager"
}

output "user_access_key" {
  value       = aws_iam_access_key.key.id
  description = "Access Key do usuario de servico IAM"
}

output "user_secret_key" {
  value       = aws_iam_access_key.key.secret
  description = "Secret Key do usuario de servico IAM"
}