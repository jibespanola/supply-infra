resource "aws_iam_role" "ecs-host-role" {
  name               = "${var.env}_ecs_host_role_${var.region}"
  assume_role_policy = file("../modules/iam/policies/ecs-role.json")
}

resource "aws_iam_role_policy" "ecs-instance-role-policy" {
  name   = "${var.env}_ecs_instance_role_policy_${var.region}"
  policy = file("../modules/iam/policies/ecs-instance-role-policy.json")
  role   = aws_iam_role.ecs-host-role.id
}

resource "aws_iam_role_policy" "ssm-instance-core-role-policy" {
  name   = "${var.env}_ssm_instance_core_role_policy_${var.region}"
  policy = file("../modules/iam/policies/ssm-instance-core-role-policy.json")
  role   = aws_iam_role.ecs-host-role.id
}

resource "aws_iam_role_policy" "ssm-instance-patch-role-policy" {
  name   = "${var.env}_ssm_instance_patch_role_policy_${var.region}"
  policy = file("../modules/iam/policies/ssm-instance-patch-role-policy.json")
  role   = aws_iam_role.ecs-host-role.id
}

resource "aws_iam_role" "ecs-service-role" {
  name               = "${var.env}_ecs_service_role_${var.region}"
  assume_role_policy = file("../modules/iam/policies/ecs-role.json")
}

resource "aws_iam_role_policy" "ecs-service-role-policy" {
  name   = "${var.env}_ecs_service_role_policy_${var.region}"
  policy = file("../modules/iam/policies/ecs-service-role-policy.json")
  role   = aws_iam_role.ecs-service-role.id
}

resource "aws_iam_instance_profile" "ecs" {
  name = "${var.env}_ecs_instance_profile_${var.region}"
  path = "/"
  role = aws_iam_role.ecs-host-role.name
}

variable "env" {
  type = string
}

variable "region" {
  type = string
}
