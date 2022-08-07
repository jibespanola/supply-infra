# Global Config
region   = "ap-southeast-1"
env      = "dev"
app_name = "supplycart"

# VPC
# Note: at least 2 AZS are needed to create an RDS database
cidr_block             = "172.35.0.0/16"
vpc_availability_zones = ["ap-southeast-1a", "ap-southeast-1c"]
vpc_public_subnets     = ["172.35.0.0/24", "172.35.1.0/24"]
vpc_private_subnets    = ["172.35.10.0/24", "172.35.11.0/24"]
vpc_database_subnets   = ["172.35.20.0/24", "172.35.21.0/24"]

# S3 flow logs bucket
flow_logs_bucket_name = "s3-flow-logs-dev-sg"

# Security Group names
alb_security_group = "alb-sg"
ecs_security_group = "ecs-sg"
rds_security_group = "rds-sg"

# RDS
rds_instance_class = "db.t2.micro"

# ECS infra
ami               = "ami-02af03988afacfca4"
instance_type     = "t2.small"
autoscale_min     = "2"
autoscale_max     = "3"
autoscale_desired = "2"

# RDS
# rds_address = "instahomes-manual-test.cpz8fhx2sayi.ap-northeast-1.rds.amazonaws.com"

# Route 53
# r53_zone_id     = "Z04854501IH7ZPNOD7OAN"
# r53_record_name = "tokyo-dev"

# Cert manager
# domain_name = "*.instahomes.com.ph"

# Container env vars
db_name               = "supplycart"
db_user               = "alec"
db_port               = "5432"
debug                 = "0"
database              = "postgres"

########
# IMAGE TAGS -- GET THE VERSIONS FROM THE APP REPO CI OUTPUTS #
#########
# django_image_tag = "dev-1.0.3-11af1fe"
# react_image_tag  = "dev-0.1.0-f15c84f"
