variable "account_project_base_name" {
  type        = string
  description = "Nome base do projeto"
}

variable "protocol" {
  type        = string
  description = "Tipo de procolo a ser utilizado para o topico SNS"
}

variable "endpoint" {
  type        = list(string)
  description = "Lista de endpoints a ser cadastrado no topico SNS"
}