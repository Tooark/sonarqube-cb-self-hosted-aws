#Network confugurations
module "vpc" {
  source = "./modules/vpc"

  account_project_base_name = var.account_project_base_name
  vpc_cidr                  = var.vpc_cidr
}

module "private_subnets" {
  source = "./modules/private_subnet"

  account_project_base_name = var.account_project_base_name

  vpc_id         = module.vpc.vpc_id
  vpc_cidr       = module.vpc.vpc_cidr
  subnets        = var.private_subnets
  public_subnets = module.public_subnets.subnet_id

  depends_on = [module.vpc]
}

module "public_subnets" {
  source = "./modules/public_subnet"

  account_project_base_name = var.account_project_base_name

  vpc_id              = module.vpc.vpc_id
  subnets             = var.public_subnets
  internet_gateway_id = module.vpc.internet_gateway_id

  depends_on = [module.vpc]
}

module "sg_rds" {
  source = "./modules/security_group"

  name                      = "${var.account_project_base_name}-rds"
  account_project_base_name = var.account_project_base_name
  vpc_id                    = module.vpc.vpc_id
  ingress_rules = concat([
    {
      from_port                = 5432
      to_port                  = 5432
      protocol                 = "tcp"
      source_security_group_id = module.sg_ec2.security_group_id
    }
  ], var.rds_ingress_rules)
  egress_rules = var.rds_egress_rules
}

module "rds" {
  source = "./modules/rds"

  account_project_base_name = var.account_project_base_name

  private_subnets         = module.private_subnets.subnet_id
  engine                  = var.sql_engine
  engine_version          = var.sql_engine_version
  db_name                 = var.sql_database_name
  instance_class          = var.sql_instance_class
  backup_retention_period = var.sql_backup_retention_period
  allocated_storage       = var.sql_allocated_storage
  security_group          = [module.sg_rds.security_group_id]

  depends_on = [module.sg_rds]
}

module "ec2_instance_connector_endpoint" {
  source = "./modules/instance_connector_endpoint"

  account_project_base_name = var.account_project_base_name
  subnet_id                 = module.ec2.subnet_id
}

module "sg_ec2" {
  source = "./modules/security_group"

  account_project_base_name = var.account_project_base_name
  vpc_id                    = module.vpc.vpc_id
  name                      = "${var.account_project_base_name}-host"
  ingress_rules = concat([
    {
      from_port                = 80
      to_port                  = 80
      protocol                 = "tcp"
      source_security_group_id = module.sg_lb.security_group_id
    },
    {
      from_port                = 22
      to_port                  = 22
      protocol                 = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    }
  ], var.ec2_ingress_rules)
  egress_rules = var.ec2_egress_rules
}

module "ec2" {
  source = "./modules/ec2"

  name                       = var.ec2_name
  account_project_base_name  = var.account_project_base_name
  img_owner                  = var.ec2_img_owner
  image                      = var.ec2_image
  subnet_id                  = module.private_subnets.subnet_id[0]
  disk_size                  = var.ec2_disk_size
  ip_public                  = var.ec2_ip_public
  instance_type              = var.ec2_instance_type
  security_group_ids         = [module.sg_ec2.security_group_id]
  aditional_role_permissions = var.ec2_instance_profile_aditional_permissions
  cw_sns_topic_arn           = module.sns.arn
  user_data_script = templatefile("./user_data.tpl", {
    sonar_version = var.sonar_version
    domain_name = var.sonar_domain_name
    })

  depends_on = [
    module.private_subnets,
    module.sg_ec2
  ]
}

# Load balancer
module "target_group_lb_tcp" {
  source = "./modules/target_group"

  account_project_base_name = var.account_project_base_name
  vpc_id                    = module.vpc.vpc_id
  protocol                  = var.tg_protocol
  port                      = var.tg_port
  target_id                 = module.ec2.id
  matcher_status_code       = var.tg_matcher_status_code
}

module "certificate" {
  source = "./modules/certificate"
  
  domain_name              = var.cert_domain_name
  domain_alternative_names = var.cert_domain_alternative_names
  validation_method        = var.cert_validation_method
}


module "sg_lb" {
  source = "./modules/security_group"

  account_project_base_name = var.account_project_base_name
  vpc_id                    = module.vpc.vpc_id
  name                      = "${var.account_project_base_name}-lb"
  ingress_rules             = var.lb_ingress_rules
  egress_rules              = var.lb_egress_rules
}

module "lb" {
  source = "./modules/load_balancer"

  account_project_base_name = var.account_project_base_name
  subnets                   = module.public_subnets.subnet_id
  internal                  = var.lb.internal
  load_balancer_type        = var.lb.lb_type
  security_group            = [module.sg_lb.security_group_id]
  delete_protection         = var.lb.delete_protection

  #Listener rules
  port_http                = var.listener_rule_http.port
  protocol_http            = var.listener_rule_http.protocol
  default_action_type_http = var.listener_rule_http.default_action_type
  redirect_port            = var.listener_rule_http.redirect_port
  redirect_protocol        = var.listener_rule_http.redirect_protocol
  redirect_status_code     = var.listener_rule_http.redirect_status_code
  tg_arn                   = module.target_group_lb_tcp.arn

  port_https                = var.listener_rule_https.port
  protocol_https            = var.listener_rule_https.protocol
  ssl_policy_https          = var.listener_rule_https.ssl_policy
  certificate_arn           = module.certificate.arn
  default_action_type_https = var.listener_rule_https.default_action_type

  depends_on = [module.certificate, module.target_group_lb_tcp]
}

module "sns" {
  source = "./modules/sns"

  account_project_base_name = var.account_project_base_name
  protocol                  = var.sns_protocol
  endpoint                  = var.sns_endpoints
}

module "waf" {
  source = "./modules/waf"

  account_project_base_name   = var.account_project_base_name
  resource_association_arn    = [module.lb.arn]
  regional_country_codes_rule = var.waf_regional_country_codes
  managed_rule_groups         = var.waf_managed_rule_groups
  logs_retention_period       = var.waf_logs_retention_period

  depends_on = [module.lb]
}