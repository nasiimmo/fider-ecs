module "network" {
  source             = "./modules/vpc"
  vpc_cidr           = var.vpc_cidr
  availability_zones = var.availability_zones
  environment        = var.environment
  name_prefix        = var.name_prefix
}

module "acm" {
  source      = "./modules/acm"
  domain_name = var.domain_name
  environment = var.environment
  name_prefix = var.name_prefix
}

module "rds" {
  source             = "./modules/rds"
  vpc_id             = module.network.vpc_id
  private_subnet_ids = module.network.private_subnet_ids
  db_name            = var.db_name
  db_username        = var.db_username
  db_password        = var.db_password
  # ecs_security_group_id = module.ecs.ecs_security_group_id
  vpc_cidr    = var.vpc_cidr
  environment = var.environment
  name_prefix = var.name_prefix
}

module "iam" {
  source      = "./modules/iam"
  environment = var.environment
  name_prefix = var.name_prefix
}