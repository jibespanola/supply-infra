output "default-target-group-arn" {
  value = aws_alb_target_group.default-target-group.arn
}

output "backend-target-group-arn" {
  value = aws_alb_target_group.backend-target-group.arn
}

output "ecs-alb-http-listener" {
  value = aws_alb_listener.ecs-alb-https-listener
}

output "alb_hostname" {
  value = aws_lb.loadbalancer.dns_name
}
