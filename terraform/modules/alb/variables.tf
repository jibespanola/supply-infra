variable "alb_name" {
  description = "ALB name"
  type        = string
}
variable "vpc_id" {
  description = "VPC ID to host the ALB"
  type        = string
}
variable "backend_tg_name" {
  description = "Backend target group name"
  type        = string
}
variable "frontend_tg_name" {
  description = "Frontend target group name"
  type        = string
}
variable "alb_security_groups" {
  description = "List of ALB security group"
  type        = list(string)
}
variable "alb_subnets" {
  description = "List of ALB subnets"
  type        = list(string)
}
# variable "r53_zone_id" {
#   description = "Route 53 zone ID"
#   type        = string
# }
# variable "r53_record_name" {
#   description = "Route 53 record name"
#   type        = string
# }
# variable "domain_name" {
#   description = "Domain to be registered for cert manager"
#   type        = string
# }
