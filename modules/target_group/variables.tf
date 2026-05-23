variable "account_project_base_name" {
  type        = string
  description = "Nome base do projeto"
}

variable "vpc_id" {
  type        = string
  description = "Id da vpc"
}

variable "protocol" {
  type        = string
  description = "Protocolo de destino para o Target Group"
}

variable "port" {
  type        = number
  description = "Porta para o Target Group"
}

variable "target_id" {
  type        = string
  description = "ID do target de destino"
}

variable "matcher_status_code" {
  type        = string
  description = "Status code para target group"
  default     = "200"
}