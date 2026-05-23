variable "domain_name" {
  type        = string
  description = "Nome do dominio route53 para criar o certificado"
}

variable "domain_alternative_names" {
  type        = list(string)
  description = "Outros nomes de dominio para o certificado"
}

variable "validation_method" {
  type        = string
  description = "Tipo de validacao para o certificado"
}