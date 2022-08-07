resource "aws_autoscaling_group" "ecs-cluster" {
  name                 = "${var.ecs_cluster_name}_auto_scaling_group"
  min_size             = var.autoscale_min
  max_size             = var.autoscale_max
  desired_capacity     = var.autoscale_desired
  health_check_type    = "EC2"
  launch_configuration = var.launch_configuration
  vpc_zone_identifier  = var.private_subnets
}
