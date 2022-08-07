variable "backend_container_definitions" {
}
variable "frontend_container_definitions" {
}
variable "ecs_security_group" {
  description = "List of ECS security groups"
  type        = list(string)
}
variable "ecs_cluster_name" {
  type = string
}
variable "app_count" {
  type = number
}
variable "backend_target_group_arn" {
  type = string
}
variable "frontend_target_group_arn" {
  type = string
}
variable "backend_container_name" {
  type = string
}
variable "frontend_container_name" {
  type = string
}
variable "backend_family_name" {
  type = string
}
variable "frontend_family_name" {
  type = string
}
variable "env" {
  type = string
}
variable "instance_profile_ecs" {
  type = string
}
variable "ecs_service_role_arn" {
  type = string
}
variable "amis" {
  type = map(any)
}
variable "instance_type" {
  type = string
}
variable "region" {
  type = string
}
variable "log_group_name" {
  type = string
}
variable "log_stream_name" {
  type = string
}
variable "log_retention_in_days" {
  type = number
}

