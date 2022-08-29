resource "aws_lb" "loadbalancer" {
  name               = var.alb_name
  load_balancer_type = "application"
  internal           = false
  security_groups    = var.alb_security_groups
  subnets            = var.alb_subnets
}

# Target group backend
resource "aws_alb_target_group" "backend-target-group" {
  name     = var.backend_tg_name
  port     = 8000
  protocol = "HTTP"
  vpc_id   = var.vpc_id

  health_check {
    path                = "/ping"
    port                = "traffic-port"
    healthy_threshold   = 5
    unhealthy_threshold = 2
    timeout             = 2
    interval            = 5
    matcher             = "200"
  }
}

# Target group frontend
resource "aws_alb_target_group" "default-target-group" {
  name     = var.frontend_tg_name
  port     = 80
  protocol = "HTTP"
  vpc_id   = var.vpc_id

  health_check {
    path                = "/"
    port                = "traffic-port"
    healthy_threshold   = 5
    unhealthy_threshold = 2
    timeout             = 2
    interval            = 5
    matcher             = "200"
  }
}

# Listener (redirects traffic from the load balancer to the target group)
resource "aws_alb_listener" "ecs-alb-https-listener" {
  load_balancer_arn = aws_lb.loadbalancer.id
  port              = "80"
  protocol          = "HTTP"
  # ssl_policy        = "ELBSecurityPolicy-2016-08"
  # certificate_arn   = aws_acm_certificate.cert.arn
  depends_on = [aws_alb_target_group.default-target-group]

  default_action {
    type             = "forward"
    target_group_arn = aws_alb_target_group.default-target-group.arn
  }
}

// User Listener Rule (redirects traffic from the load balancer to the target group)
resource "aws_lb_listener_rule" "static" {
  listener_arn = aws_alb_listener.ecs-alb-https-listener.arn
  priority     = 100

  action {
    type             = "forward"
    target_group_arn = aws_alb_target_group.backend-target-group.arn
  }

  condition {
    path_pattern {
      values = ["/admin*", "/ping*", "/api*", "/graphql*"]
    }
  }
}

# resource "aws_acm_certificate" "cert" {
#   domain_name       = var.domain_name
#   validation_method = "DNS"

#   lifecycle {
#     create_before_destroy = true
#   }
# }

# resource "aws_route53_record" "record" {
#   zone_id = var.r53_zone_id
#   name    = var.r53_record_name
#   type    = "A"

#   alias {
#     name                   = aws_lb.loadbalancer.dns_name
#     zone_id                = aws_lb.loadbalancer.zone_id
#     evaluate_target_health = true
#   }
# }
