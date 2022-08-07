variable "rds_security_group" {
  description = "Security group for DB instance"
  type        = string
}
variable "identifier" {
  description = "DB instance identifier"
  type        = string
}
variable "subnet_ids" {
  description = "Subnet IDs for DB instance"
  type        = list(string)
}
variable "rds_subnet_group" {
  description = "DB subnet group"
  type        = string
}
variable "db_name" {
  description = "Main DB name"
  type        = string
}
variable "db_user" {
  description = "Main DB username"
  type        = string
}
variable "db_password" {
  description = "Main DB password"
  type        = string
}
variable "rds_instance_class" {
  description = "DB instance class"
  type        = string
}
variable "snapshot_identifier" {
  description = "Snapshot identifier"
  type        = string
}
