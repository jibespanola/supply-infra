variable "region" {
  type = string
}
variable "env" {
  type = string
}
variable "app_name" {
  type = string
}

# VPC
variable "vpc_private_subnets" {
  description = "List of CIDR blocks"
  type        = list(string)
}
variable "vpc_public_subnets" {
  description = "List of CIDR blocks"
  type        = list(string)
}
variable "vpc_database_subnets" {
  description = "List of CIDR blocks"
  type        = list(string)
}
variable "cidr_block" {
  description = "List of CIDR blocks"
  type        = string
}
variable "vpc_availability_zones" {
  description = "Availability zones"
  type        = list(string)
  default     = ["us-west-2a", "us-west-2b"]
}


# S3
variable "flow_logs_bucket_name" {
  type = string
}

# Security Groups
variable "alb_security_group" {
  description = "Security group name for ALB"
  type        = string
}
variable "ecs_security_group" {
  description = "Security group name for ECS"
  type        = string
}
variable "rds_security_group" {
  description = "Security group name for RDS"
  type        = string
}

# RDS
variable "rds_address" {
  type = string
}


# ECS
variable "react_image_tag" {
  type = string
}

variable "django_image_tag" {
  type = string
}

variable "db_name" {
  type    = string
  default = "instahomes"
}
variable "database" {
  type    = string
  default = "postgres"
}
variable "db_user" {
  type    = string
  default = "alec"
}
variable "db_port" {
  type    = string
  default = "5432"
}
variable "aws_s3_file_overwrite" {
  type    = string
  default = "True"
}
variable "use_s3" {
  type    = string
  default = "True"
}
variable "debug" {
  type    = string
  default = "0"
}

variable "ami" {
  type    = string
  default = "ami-0ec2e33c6e1161e98"
}
variable "r53_zone_id" {
  description = "Route 53 zone ID"
  type        = string
}
variable "r53_record_name" {
  description = "Route 53 record name"
  type        = string
}
variable "instance_type" {
  type = string
}
variable "autoscale_min" {
  type = string
}
variable "autoscale_max" {
  type = string
}
variable "autoscale_desired" {
  type = string
}
variable "rds_instance_class" {
  type = string
}
variable "domain_name" {
  type = string
}
