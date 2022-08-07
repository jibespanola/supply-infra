resource "aws_vpc_endpoint" "ssm" {
  vpc_id            = var.vpc_id
  service_name      = "com.amazonaws.${var.region}.ssm"
  vpc_endpoint_type = "Interface"

  security_group_ids = var.security_group_ids
  subnet_ids         = var.subnet_ids

  private_dns_enabled = true
}

resource "aws_vpc_endpoint" "ec2-messages" {
  vpc_id            = var.vpc_id
  service_name      = "com.amazonaws.${var.region}.ec2messages"
  vpc_endpoint_type = "Interface"

  security_group_ids = var.security_group_ids
  subnet_ids         = var.subnet_ids

  private_dns_enabled = true
}

resource "aws_vpc_endpoint" "ssm-messages" {
  vpc_id            = var.vpc_id
  service_name      = "com.amazonaws.${var.region}.ssmmessages"
  vpc_endpoint_type = "Interface"

  security_group_ids = var.security_group_ids
  subnet_ids         = var.subnet_ids

  private_dns_enabled = true
}
