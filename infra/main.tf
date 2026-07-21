# Test 2

module "network" {
  source             = "./modules/vpc"
  vpc_cidr           = var.vpc_cidr
  availability_zones = var.availability_zones
  environment        = var.environment
  name_prefix        = var.name_prefix
}

module "acm" {
  source               = "./modules/acm"
  domain_name          = var.domain_name
  environment          = var.environment
  name_prefix          = var.name_prefix
  cloudflare_zone_id   = var.cloudflare_zone_id
  cloudflare_api_token = var.cloudflare_api_token
}

module "rds" {
  source             = "./modules/rds"
  vpc_id             = module.network.vpc_id
  private_subnet_ids = module.network.private_subnet_ids
  db_name            = var.db_name
  db_username        = var.db_username
  db_password        = var.db_password
  ecs_security_group_id = module.ecs.ecs_security_group_id
  environment = var.environment
  name_prefix = var.name_prefix
}

module "iam" {
  source      = "./modules/iam"
  environment = var.environment
  name_prefix = var.name_prefix
}

module "alb" {
  source            = "./modules/alb"
  vpc_id            = module.network.vpc_id
  public_subnet_ids = module.network.public_subnet_ids
  certificate_arn   = module.acm.certificate_arn
  environment       = var.environment
  name_prefix       = var.name_prefix
}

module "ecr" {
  source          = "./modules/ecr"
  environment     = var.environment
  name_prefix     = var.name_prefix
  repository_name = "fider"
}

module "ecs" {
  source                = "./modules/ecs"
  vpc_id                = module.network.vpc_id
  private_subnet_ids    = module.network.private_subnet_ids
  alb_security_group_id = module.alb.security_group_sg
  target_group_arn      = module.alb.target_group_arn
  execution_role_arn    = module.iam.ecs_execution_role_arn
  ecr_repository_url    = module.ecr.repository_url
  image_tag             = var.image_tag
  db_endpoint           = module.rds.db_endpoint
  db_port               = module.rds.db_port
  db_name               = var.db_name
  db_username           = var.db_username
  db_password           = var.db_password
  jwt_secret            = var.jwt_secret
  domain_name           = var.domain_name
  environment           = var.environment
  name_prefix           = var.name_prefix
  alb_https_listener_arn = module.alb.https_listener_arn
}