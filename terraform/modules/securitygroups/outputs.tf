output "rds_security_group" {
  description = "The ID of RDS security group"
  value       = aws_security_group.rds.id
}

output "ecs_security_group" {
  description = "The ID of the ECS security group"
  value       = aws_security_group.ecs.id
}

output "alb_security_group" {
  description = "The ID of the ALB security group"
  value       = aws_security_group.load-balancer.id
}
