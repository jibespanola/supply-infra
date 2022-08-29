# Global Config
region   = "ap-southeast-1"
env      = "dev"
app_name = "supplycart"

# VPC
# Note: at least 2 AZS are needed to create an RDS database
cidr_block             = "172.32.0.0/16"
vpc_availability_zones = ["ap-southeast-1a", "ap-southeast-1c"]
vpc_public_subnets     = ["172.32.0.0/24", "172.32.1.0/24"]
vpc_private_subnets    = ["172.32.10.0/24", "172.32.11.0/24"]
vpc_database_subnets   = ["172.32.20.0/24", "172.32.21.0/24"]

# S3 flow logs bucket
flow_logs_bucket_name = "supplycart-s3-flow-logs"

# Security Group names
alb_security_group = "alb-sg"
ecs_security_group = "ecs-sg"
rds_security_group = "rds-sg"

# ECS infra
ami               = "ami-0a29369712cfd1acc"
instance_type     = "t2.medium"
autoscale_min     = "2"
autoscale_max     = "3"
autoscale_desired = "2"

# Route 53
# r53_zone_id     = "Z04854501IH7ZPNOD7OAN"
# r53_record_name = "tokyo-dev"

# Cert manager
# domain_name = "*.instahomes.com.ph"

# Container env vars
database  = "cockroach"
db_engine = "cockroachdb"
db_user   = "test-user"
db_name   = "supplycart-dev-2296.defaultdb"
db_host   = "free-tier8.aws-ap-southeast-1.cockroachlabs.cloud"
db_port   = "26257"

########
# IMAGE TAGS -- GET THE VERSIONS FROM THE APP REPO CI OUTPUTS #
#########
fastapi_image_tag = "dev-0.1.0-32a996d"
react_image_tag   = "dev-3.1.2-32a996d"
