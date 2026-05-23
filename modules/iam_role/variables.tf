variable "account_project_base_name" {
  type        = string
  description = "Nome base do projeto"
}

variable "role_name" {
  type        = string
  description = "Nome de identificação na role com o padrão 'role-<SEU-INPUT>-nomeBaseDoProjeto'"
}

variable "assume_role" {
  type        = list(string)
  description = "Serviço que irá ser assumido o acesso"
  default = ["ec2.amazonaws.com"]
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