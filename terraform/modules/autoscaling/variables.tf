variable "autoscale_min" {
  type = string
}
variable "autoscale_max" {
  type = string
}
variable "autoscale_desired" {
  type = string
}
variable "launch_configuration" {
  type = string
}
variable "private_subnets" {
  description = "List of private subnets for autoscaling group"
  type        = list(string)
}
variable "ecs_cluster_name" {
  description = "ECS cluster that the autoscaling group will be applied to"
  type        = string
}
