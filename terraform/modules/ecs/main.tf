resource "aws_ecs_cluster" "cluster" {
  name = "${var.ecs_cluster_name}-cluster"
}

resource "aws_launch_configuration" "ecs" {
  name                        = "${var.ecs_cluster_name}-cluster"
  image_id                    = lookup(var.amis, var.region)
  instance_type               = var.instance_type
  security_groups             = var.ecs_security_group
  iam_instance_profile        = var.instance_profile_ecs
  associate_public_ip_address = false
  user_data                   = "#!/bin/bash\necho ECS_CLUSTER='${var.ecs_cluster_name}-cluster' > /etc/ecs/ecs.config"
}


resource "aws_ecs_task_definition" "backend" {
  family                = var.backend_family_name
  container_definitions = var.backend_container_definitions

  volume {
    name      = "cockroach_ca"
    host_path = "/home/ssm-user/.postgresql/root.crt"
  }
}

resource "aws_ecs_task_definition" "frontend" {
  family                = var.frontend_family_name
  container_definitions = var.frontend_container_definitions
}

resource "aws_ecs_service" "fastapi" {
  name            = "${var.ecs_cluster_name}-fastapi-service"
  cluster         = aws_ecs_cluster.cluster.id
  task_definition = aws_ecs_task_definition.backend.arn
  iam_role        = var.ecs_service_role_arn
  desired_count   = var.app_count

  load_balancer {
    target_group_arn = var.backend_target_group_arn
    container_name   = var.backend_container_name
    container_port   = 8001
  }
}

resource "aws_ecs_service" "react" {
  name            = "${var.ecs_cluster_name}-react-service"
  cluster         = aws_ecs_cluster.cluster.id
  task_definition = aws_ecs_task_definition.frontend.arn
  iam_role        = var.ecs_service_role_arn
  desired_count   = var.app_count

  load_balancer {
    target_group_arn = var.frontend_target_group_arn
    container_name   = var.frontend_container_name
    container_port   = 3000
  }
}

resource "aws_cloudwatch_log_group" "backend-log-group" {
  name              = "${var.log_group_name}-fastapi"
  retention_in_days = var.log_retention_in_days
}

resource "aws_cloudwatch_log_stream" "backend-log-stream" {
  name           = "fastapi-${var.log_stream_name}"
  log_group_name = aws_cloudwatch_log_group.backend-log-group.name
}

resource "aws_cloudwatch_log_group" "frontend-log-group" {
  name              = "${var.log_group_name}-react"
  retention_in_days = var.log_retention_in_days
}

resource "aws_cloudwatch_log_stream" "frontend-log-stream" {
  name           = "react-${var.log_stream_name}"
  log_group_name = aws_cloudwatch_log_group.frontend-log-group.name
}

