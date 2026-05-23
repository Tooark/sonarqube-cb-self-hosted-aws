variable "name" {
  type        = string
  description = "Nome do secret"
}

variable "values" {
  description = "Valores a serem armanzenados no secret. Pode ser um mapa (map(string)) ou uma string simples (texto/json)."
  type        = any
}