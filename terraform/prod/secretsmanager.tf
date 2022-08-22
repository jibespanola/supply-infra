data "aws_secretsmanager_secret_version" "creds" {
  secret_id = "ecs-creds-supplycart-prod"
}

locals {
  ecs_creds_supplycart = jsondecode(
    data.aws_secretsmanager_secret_version.creds.secret_string
  )
}
