module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "3.2.0"

  name = "${var.region}-${var.env}-vpc-supplycart"
  cidr = var.cidr_block

  azs              = var.vpc_availability_zones
  database_subnets = var.vpc_database_subnets
  private_subnets  = var.vpc_private_subnets
  public_subnets   = var.vpc_public_subnets

  enable_nat_gateway   = true
  single_nat_gateway   = true
  enable_vpn_gateway   = false
  enable_dns_support   = true
  enable_dns_hostnames = true


  enable_flow_log           = true
  flow_log_destination_type = "s3"
  flow_log_destination_arn  = module.logs_bucket.s3_bucket_arn
}

module "securitygroups" {
  source = "../modules/securitygroups"

  alb_security_group = "${var.app_name}-${var.env}-${var.alb_security_group}"
  ecs_security_group = "${var.app_name}-${var.env}-${var.ecs_security_group}"
  rds_security_group = "${var.app_name}-${var.env}-${var.rds_security_group}"

  vpc_id         = module.vpc.vpc_id
  vpc_cidr_block = module.vpc.vpc_cidr_block
}

module "ssm" {
  source             = "../modules/ssm"
  vpc_id             = module.vpc.vpc_id
  security_group_ids = [module.securitygroups.ecs_security_group]
  subnet_ids         = module.vpc.private_subnets
  region             = var.region
}

module "alb" {
  source              = "../modules/alb"
  alb_name            = "${var.app_name}-${var.env}-alb"
  alb_security_groups = [module.securitygroups.alb_security_group]
  alb_subnets         = module.vpc.public_subnets
  vpc_id              = module.vpc.vpc_id
  backend_tg_name     = "${var.app_name}-${var.env}-backend-tg"
  frontend_tg_name    = "${var.app_name}-${var.env}-frontend-tg"
  # r53_record_name     = var.r53_record_name
  # r53_zone_id         = var.r53_zone_id
  # domain_name         = var.domain_name
}

module "iam" {
  source   = "../modules/iam"
  env      = var.env
  region   = var.region
  app_name = var.app_name
}

output "alb_hostname" {
  value = module.alb.alb_hostname
}
