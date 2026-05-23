variable "name" {
  type        = string
  description = "Nome do usuario IAM"
}

variable "permission_effect" {
  type        = string
  description = "Efeito da permissao"
}

variable "permissions" {
  type        = list(string)
  description = "Lista de permissoes para a service account"
}

variable "permission_resources_arn" {
  type        = list(string)
  description = "Lista de servicos para permissao(ARN)"
}