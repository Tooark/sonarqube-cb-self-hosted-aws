variable "account_project_base_name" {
  type        = string
  description = "Nome base do projeto"
}

variable "internal" {
  type        = bool
  description = "Define se o Load Balancer será interno ou externo"
}

variable "load_balancer_type" {
  type        = string
  description = "Define o tipo do load balancer"
}

variable "security_group" {
  type        = list(string)
  description = "Define os security groups do Load Balancer"
}

variable "subnets" {
  type        = list(string)
  description = "Define uma lista de ids das subnets vinculadas ao Load Balancer"
}

variable "delete_protection" {
  type        = bool
  description = "Define se a proteção contra destruição está habilitada"
  default     = true
}

#Listener HTTP
variable "port_http" {
  type        = string
  description = "Porta para a listener rule http"
}

variable "protocol_http" {
  type        = string
  description = "Protocolo para a listener rule http"
}

variable "default_action_type_http" {
  type        = string
  description = "Acao padrao para a listener rule http"
}

variable "redirect_port" {
  type        = string
  description = "Porta de redirecnionamento"
}

variable "redirect_protocol" {
  type        = string
  description = "Protocolo de redirecionamento"
}

variable "redirect_status_code" {
  type        = string
  description = "Status code do redirect"
}

#Listener HTTPS
variable "port_https" {
  type        = string
  description = "Porta para a listener rule https"
}

variable "protocol_https" {
  type        = string
  description = "Protocolo para a listener rule https"
}

variable "ssl_policy_https" {
  type        = string
  description = "Politica SSL usada na regra de https"
}

variable "certificate_arn" {
  type        = string
  description = "ARN do certificado para regra https"
  default     = ""
}

variable "default_action_type_https" {
  type        = string
  description = "Acao padrao para a regra https"
}

variable "tg_arn" {
  type        = string
  description = "ARN do Target group de destino para a regra https"
}