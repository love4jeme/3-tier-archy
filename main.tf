module "vpc" {
  source               = "./modules/vpc"
  project_name         = var.project_name
  vpc_cidr             = var.vpc_cidr
  public_subnet_cidrs  = local.public_subnet_cidrs
  private_subnet_cidrs = local.private_subnet_cidrs
  data_subnet_cidrs    = local.data_subnet_cidrs
  azs                  = local.azs
  common_tags          = local.common_tags
}

module "alb" {
  source            = "./modules/alb"
  project_name      = var.project_name
  vpc_id            = module.vpc.vpc_id
  public_subnet_ids = module.vpc.public_subnet_ids
  common_tags       = local.common_tags
}

module "asg" {
  source             = "./modules/asg"
  project_name       = var.project_name
  vpc_id             = module.vpc.vpc_id
  private_subnet_ids = module.vpc.private_subnet_ids
  target_group_arn   = module.alb.target_group_arn
  my_ip              = var.my_ip
  key_pair_name      = var.key_pair_name
  common_tags        = local.common_tags
}

module "rds" {
  source          = "./modules/rds"
  project_name    = var.project_name
  vpc_id          = module.vpc.vpc_id
  data_subnet_ids = module.vpc.data_subnet_ids
  asg_sg_id       = module.asg.asg_sg_id
  db_username     = var.db_username
  db_password     = var.db_password
  common_tags     = local.common_tags
}
