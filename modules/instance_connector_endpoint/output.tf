output "id" {
  value       = aws_ec2_instance_connect_endpoint.main.id
  description = "Id do Endpoint"
}

output "arn" {
  value       = aws_ec2_instance_connect_endpoint.main.arn
  description = "Arn do Endpoint"
}

output "subnet_endpoint_id" {
  value       = aws_ec2_instance_connect_endpoint.main.subnet_id
  description = "ID da Subnet no Endpoint"
}