output "id" {
  value       = aws_cloudwatch_metric_alarm.ec2_status_check_failed.id
  description = "ID do alarme que reinicia a ec2"
}

output "arn" {
  value       = aws_cloudwatch_metric_alarm.ec2_status_check_failed.arn
  description = "ARN do alarme que reinicia a ec2"
}

output "name" {
  value       = aws_cloudwatch_metric_alarm.ec2_status_check_failed.alarm_name
  description = "ID do alarme que reinicia a ec2"
}