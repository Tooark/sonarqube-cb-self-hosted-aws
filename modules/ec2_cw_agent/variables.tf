variable "target_tag" {
  type        = string
  description = "Tag de target pro CloudWatchAgent"
}

variable "target_values" {
  type        = list(string)
  description = "Valor da tag target pro CloudWatchAgent"
}

variable "action" {
  type        = string
  description = "Tipo de ação na ec2"
  default     = "Install"
}

variable "package_name" {
  type        = string
  description = "Nome do pacote a ser executado a ação na ec2"
  default     = "AmazonCloudWatchAgent"
}

variable "instance_name" {
  type        = string
  description = "Nome da ec2"
}