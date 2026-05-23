variable "account_region" {
  type        = string
  description = "Região para da conta"
}
variable "account_project_base_name" {
  type        = string
  description = "Nome base do projeto"
}
variable "default_tags" {
  type        = map(string)
  description = "Tags padrão para os recursos"
}

#Network definitions
variable "vpc_cidr" {
  type        = string
  description = "Primary VPC CIDR"
}

variable "public_subnets" {
  description = "List of public subnets in the VPC"
  type = list(object({
    name              = string
    cidr              = string
    availability_zone = string
  }))
}

variable "private_subnets" {
  description = "List of private subnets in the VPC"
  type = list(object({
    name              = string
    cidr              = string
    availability_zone = string
  }))
}

#Ec2
variable "ec2_name" {
  type        = string
  description = "Nome da instância EC2"
}
variable "ec2_disk_size" {
  type        = number
  description = "Tamanho do disco na ec2"
}
variable "ec2_img_owner" {
  type        = list(string)
  description = "Proprietario da criação da imagem"
}
variable "ec2_image" {
  type        = list(string)
  description = "Nome da imagem para Ec2"
}
variable "ec2_instance_type" {
  type        = string
  description = "Tipo da instancia Ec2"
}
variable "ec2_ip_public" {
  type        = bool
  description = "Especifica se a instancia tera ip publico"
}
variable "ec2_instance_profile_aditional_permissions" {
  type        = list(string)
  description = "Lista de permissoes adicionais para o Instance Profile da ec2"
}
variable "ec2_egress_rules" {
  type = list(object({
    from_port                = number
    to_port                  = number
    protocol                 = string
    cidr_blocks              = optional(list(string))
    source_security_group_id = optional(string)
  }))
  description = "Lista de regras de entrada"
}
variable "ec2_ingress_rules" {
  type = list(object({
    from_port                = number
    to_port                  = number
    protocol                 = string
    cidr_blocks              = optional(list(string))
    source_security_group_id = optional(string)
  }))
  description = "Lista de regras de entrada"
}

#RDS

variable "sql_instance_class" {
  type        = string
  description = "RDS instance class"
}
variable "sql_engine" {
  type        = string
  description = "RDS engine"
}
variable "sql_engine_version" {
  type        = string
  description = "RDS engine version"
}
variable "sql_database_name" {
  type        = string
  description = "Database to be created on the RDS"
}
variable "sql_backup_retention_period" {
  type        = number
  description = "RDS backup retention period (days)"
}
variable "sql_allocated_storage" {
  type        = number
  description = "RDS allocated storage size (GB)"
}
variable "rds_ingress_rules" {
  type = list(object({
    from_port                = number
    to_port                  = number
    protocol                 = string
    cidr_blocks              = optional(list(string))
    source_security_group_id = optional(string)
  }))
  description = "List of ingress rules"
}
variable "rds_egress_rules" {
  type = list(object({
    from_port                = number
    to_port                  = number
    protocol                 = string
    cidr_blocks              = optional(list(string))
    source_security_group_id = optional(string)
  }))
  description = "List of egress rules"
}

#Sonar
variable "sonar_version" {
  type        = string
  description = "Versao do Sonarqube Community Edition"
}

#Target Group
variable "tg_protocol" {
  type        = string
  description = "Protocolo do target group"
}
variable "tg_port" {
  type        = number
  description = "Porta para o target group"
}
variable "tg_matcher_status_code" {
  type        = string
  description = "Codigos para marcar o alvo como Saudavel"
}


#Certificate
variable "cert_domain_name" {
  type        = string
  description = "Nome do dominio para o certificado"
}
variable "cert_domain_alternative_names" {
  type        = list(string)
  description = "Nomes alternativos para o certificado"
}
variable "cert_validation_method" {
  type        = string
  description = "Metodo de validacao do certificado"
}

#LB
variable "lb" {
  type = object({
    internal          = bool
    lb_type           = string
    logs              = bool
    delete_protection = bool
  })
}
variable "lb_egress_rules" {
  type = list(object({
    from_port                = number
    to_port                  = number
    protocol                 = string
    cidr_blocks              = optional(list(string))
    source_security_group_id = optional(string)
  }))
  description = "Lista de regras de entrada"
}
variable "lb_ingress_rules" {
  type = list(object({
    from_port                = number
    to_port                  = number
    protocol                 = string
    cidr_blocks              = optional(list(string))
    source_security_group_id = optional(string)
  }))
  description = "Lista de regras de entrada"
}
variable "listener_rule_http" {
  type = object({
    port                 = number
    protocol             = string
    default_action_type  = string
    redirect_port        = number
    redirect_protocol    = string
    redirect_status_code = string
  })
}

variable "listener_rule_https" {
  type = object({
    port                = number
    protocol            = string
    ssl_policy          = string
    default_action_type = string
  })
}

#Clouwatch Alarms + SNS topic Subscription
variable "sns_protocol" {
  type        = string
  description = "Protocolo de inscrição no topico SNS"
}

variable "sns_endpoints" {
  type        = list(string)
  description = "Endpoints a serem inscritos no topico SNS"
}

#WAF
variable "waf_managed_rule_groups" {
  type = map(object({
    vendor_name          = string
    name                 = string
    priority             = number
    rule_action_override = optional(list(string))
  }))
  description = "List of managed rule groups for the WAF"
}
variable "waf_regional_country_codes" {
  type        = list(string)
  description = "List of country codes for regional WAF rules"
}
variable "waf_logs_retention_period" {
  type        = number
  description = "WAF logs retention period (days)"
}

#DNS
variable "sonar_domain_name" {
  type = string
  description = "Nome do dns principal do Sonarqube"
}