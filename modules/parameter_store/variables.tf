variable "name" {
  type        = string
  description = "Nome do Parameter Store"
}

variable "type" {
  type        = string
  default     = "String"
  description = "Tipo do dado do parametro armazenado"
}

variable "value" {
  type        = string
  description = "Valor a ser armanzenado no parametro"
}