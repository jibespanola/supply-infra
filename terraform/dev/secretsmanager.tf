data "aws_secretsmanager_secret_version" "creds" {
  secret_id = "ecs-creds"
}

locals {
  ecs_creds = jsondecode(
    data.aws_secretsmanager_secret_version.creds.secret_string
  )
}
