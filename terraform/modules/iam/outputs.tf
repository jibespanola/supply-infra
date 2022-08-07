output "ecs_service_role_arn" {
  description = "ARN of ecs_service_role"
  value       = aws_iam_role.ecs-service-role.arn
}

output "ecs_instance_profile" {
  value = aws_iam_instance_profile.ecs.name
}

output "ecs_service_role_policy" {
  value = aws_iam_role_policy.ecs-service-role-policy
}
