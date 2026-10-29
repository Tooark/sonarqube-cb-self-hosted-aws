# Cloudwatch
variable "comparison_operator" {
  type        = string
  description = "Operador de comparação"
  default     = "GreaterThanOrEqualToThreshold"
}

variable "evaluation_periods" {
  type        = number
  description = "Numero de periodos consecutivos com falha para a ec2 ser reiniciada"
  default     = 2
}

variable "threshold" {
  type        = number
  description = "Valor da metrica StatusCheckFailed (0 ou 1) a partir do qual o periodo conta como falha"
  default     = 1
}

variable "metric_name" {
  type        = string
  description = "Nome da metrica"
  default     = "StatusCheckFailed"
}

variable "namespace" {
  type        = string
  description = "Namespace da metrica Cloudwatch"
  default     = "AWS/EC2"
}

variable "period" {
  type        = number
  description = "Periodo de tempo entre uma verificacao e outra"
  default     = 60
}

variable "statistic" {
  type        = string
  description = "Estatistica usada"
  default     = "Maximum"
}

variable "instance_name" {
  type        = string
  description = "Nome da ec2 a ser reiniciada"
}

variable "instance_id" {
  type        = string
  description = "Id da ec2 a ser reiniciada"
}

variable "region" {
  type        = string
  description = "Regiao da ec2"
}

variable "sns_topic_arn" {
  type        = string
  description = "ARN do topico SNS"
}