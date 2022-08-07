output "address" {
  description = "Address of RDS instance"
  value       = aws_db_instance.rds_instance.address
}

output "db_instance_arn" {
  description = "The ARN of the RDS instance"
  value       = aws_db_instance.rds_instance.arn
}

output "db_instance_endpoint" {
  description = "The connection endpoint"
  value       = aws_db_instance.rds_instance.endpoint
}

output "db_instance_name" {
  description = "The database name"
  value       = aws_db_instance.rds_instance.db_name
}
