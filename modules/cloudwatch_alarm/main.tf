resource "aws_cloudwatch_metric_alarm" "ec2_status_check_failed" {
  alarm_name          = var.name
  comparison_operator = var.comparison_operator
  evaluation_periods  = var.evaluation_periods
  metric_name         = var.metric_name
  namespace           = var.namespace
  period              = var.period
  statistic           = var.statistic
  threshold           = var.threshold
  alarm_description   = var.alarm_description
  dimensions          = var.dimension

  alarm_actions = [var.sns_topic_arn]
}
