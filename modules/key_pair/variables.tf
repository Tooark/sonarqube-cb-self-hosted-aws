variable "account_project_base_name" {
  type        = string
  description = "Nome base do projeto"
  default     = "vpc"
}
variable "key_algorithm" {
  type        = string
  description = "Algoritmo da chave"
}
variable "name" {
  type        = string
  description = "Name da Key Pair"
}