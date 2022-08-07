data "template_file" "template_backend" {
  template = file("../templates/fastapi_app.json.tpl")

  vars = {
    image_target            = "011095803615.dkr.ecr.${var.region}.amazonaws.com/supplycart-backend:${var.fastapi_image_tag}"
    region                  = var.region
    db_name                 = var.db_name
    db_user                 = var.db_user
    db_password             = local.ecs_creds.db_password
    db_host                 = var.rds_address
    db_port                 = var.db_port
    database                = var.database
  }
}

data "template_file" "template_frontend" {
  template = file("../templates/react_app.json.tpl")

  vars = {
    image_target = "011095803615.dkr.ecr.${var.region}.amazonaws.com/supplycart-frontend:${var.react_image_tag}"
    env          = var.env
    region       = var.region
    app_name     = var.app_name
  }
}

module "ecs" {
  source           = "../modules/ecs"
  depends_on       = [module.alb.ecs-alb-http-listener, module.iam.ecs_service_role_policy]
  ecs_cluster_name = "${var.app_name}-${var.env}"
  instance_type    = var.instance_type
  region           = var.region
  env              = var.env
  app_count        = 1
  amis             = { "${var.region}" = "${var.ami}" }

  ecs_security_group   = [module.securitygroups.ecs_security_group]
  instance_profile_ecs = module.iam.ecs_instance_profile
  ecs_service_role_arn = module.iam.ecs_service_role_arn

  backend_container_definitions  = data.template_file.template_backend.rendered
  frontend_container_definitions = data.template_file.template_frontend.rendered

  backend_family_name  = "${var.app_name}-${var.env}-fastapi"
  frontend_family_name = "${var.app_name}-${var.env}-react"

  backend_container_name  = "${var.app_name}-${var.env}-fastapi"
  frontend_container_name = "${var.app_name}-${var.env}-react"

  backend_target_group_arn  = module.alb.backend-target-group-arn
  frontend_target_group_arn = module.alb.default-target-group-arn

  log_group_name        = "/ecs/${var.app_name}-${var.env}"
  log_stream_name       = "${var.app_name}-${var.env}-log-stream"
  log_retention_in_days = 30
}

module "autoscaling" {
  source               = "../modules/autoscaling"
  depends_on           = [module.ecs.ecs-launch-configuration]
  ecs_cluster_name     = "${var.app_name}-${var.env}"
  autoscale_min        = var.autoscale_min
  autoscale_max        = var.autoscale_max
  autoscale_desired    = var.autoscale_desired
  launch_configuration = module.ecs.ecs-launch-configuration
  private_subnets      = module.vpc.private_subnets
}
