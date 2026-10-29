output "host" {
  value       = aws_db_instance.main.address
  description = "RDS host for connection"
}

output "availability_zone" {
  value       = aws_db_instance.main.availability_zone
  description = "RDS availability zone"
}

output "port" {
  value       = aws_db_instance.main.port
  description = "Database port"
}

output "user" {
  value       = aws_db_instance.main.username
  description = "RDS default username"
}

output "password" {
  value       = aws_db_instance.main.password
  description = "RDS default password"
}

output "database" {
  value       = aws_db_instance.main.db_name
  description = "Database name"
}

output "credentials_secret_name" {
  value       = module.secret.name
  description = "Secrets Manager secret holding host, port, username, password and dbname"

  # Wait for the secret version too, so a consumer never reads an empty secret
  depends_on = [module.secret]
}

output "credentials_secret_arn" {
  value       = module.secret.arn
  description = "ARN of the Secrets Manager secret with the database credentials"

  depends_on = [module.secret]
}