variable "account_project_base_name" {
  type        = string
  description = "Nome base do projeto"
}

variable "vpc_id" {
  type        = string
  description = "Id da VPC"
}

variable "name" {
  type        = string
  description = "Nome do SG"
}

variable "ingress_rules" {
  type = list(object({
    from_port                = number
    to_port                  = number
    protocol                 = string
    cidr_blocks              = optional(list(string))
    source_security_group_id = optional(string)
  }))
  description = "Lista de regras de entrada"
}

variable "egress_rules" {
  type = list(object({
    from_port                = number
    to_port                  = number
    protocol                 = string
    cidr_blocks              = optional(list(string))
    source_security_group_id = optional(string)
  }))
  description = "Lista de regras de saida"
}