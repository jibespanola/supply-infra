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
variable "vpc_id" {
  type = string
}
variable "vpc_cidr_block" {
  type = string
}
