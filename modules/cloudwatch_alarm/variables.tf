variable "name" {
  type        = string
  description = "Nome do alarme Cloudwatch"
}

variable "comparison_operator" {
  type        = string
  description = "Operador de comparação"
}

variable "evaluation_periods" {
  type        = number
  description = "Numero de vezes que é feito a comparação de estado do desejado x estado atual do recurso"
}

variable "metric_name" {
  type        = string
  description = "Nome da metrica"
}

variable "namespace" {
  type        = string
  description = "Namespace da metrica Cloudwatch"
}

variable "threshold" {
  type        = number
  description = "Numero de falhas consecutivas para a ec2 ser reiniciada"
  default     = 2
}

variable "period" {
  type        = number
  description = "Periodo de tempo entre uma verificacao e outra"
}

variable "statistic" {
  type        = string
  description = "Estatistica usada"
}

variable "sns_topic_arn" {
  type        = string
  description = "ARN do topico SNS"
}

variable "dimension" {
  type = map(string)
}

variable "alarm_description" {
  type        = string
  description = "Descrição do alarme a ser criado"
}