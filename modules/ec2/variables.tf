variable "account_project_base_name" {
  type        = string
  description = "Nome base do projeto"
  default     = "vpc"
}
variable "account_region" {
  type        = string
  description = "Região da conta AWS (usada no ARN da acao de reboot do alarme)"
}

variable "key_pair_algorithm" {
  type        = string
  description = "Tipo de algoritmo da key pair"
  default     = "RSA"
}

variable "name" {
  type        = string
  description = "Nome da instância EC2"
}
variable "img_owner" {
  type        = list(string)
  description = "Proprietario da criação da imagem"
}
variable "image" {
  type        = list(string)
  description = "Nome da imagem para Ec2"
}
variable "instance_type" {
  type        = string
  description = "Tipo da instancia Ec2"
}
variable "subnet_id" {
  type        = string
  description = "Id da subnet associada a ec2"
}
variable "user_data_script" {
  type        = string
  description = "Caminho para o script de inicialização da Ec2"
}
variable "security_group_ids" {
  type        = list(string)
  description = "Id dos grupos de segurança para a Ec2"
}
variable "ip_public" {
  type        = bool
  description = "Ativa ip publico na Ec2"
  default     = false
}
variable "disk_size" {
  type        = number
  description = "Tamanho do disco na ec2"
}
variable "disk_type" {
  type        = string
  description = "Tipo do disco na ec2"
  default     = "gp3"
}
variable "spot_instance" {
  type        = bool
  description = "Ativa a instancia spot"
  default     = false
}
variable "aditional_role_permissions" {
  type        = list(string)
  description = "Permissões adicionais para a instância"
  default     = []
}
variable "cw_sns_topic_arn" {
  type        = string
  description = "ARN do topico SNS"
}
variable "secrets_read_arns" {
  type        = list(string)
  description = "ARNs de secrets do Secrets Manager que a instancia pode ler (ex.: credenciais do banco)"
  default     = []
}