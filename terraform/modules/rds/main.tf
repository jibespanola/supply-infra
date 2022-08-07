resource "aws_db_subnet_group" "rds_subnet_group" {
  name       = var.rds_subnet_group
  subnet_ids = var.subnet_ids
}

resource "aws_db_instance" "rds_instance" {
  identifier = var.identifier
  db_name    = var.db_name
  username   = var.db_user
  password   = var.db_password
  port       = "5432"
  # engine         = "postgres"
  engine_version          = "12.8"
  instance_class          = var.rds_instance_class
  allocated_storage       = "20"
  storage_encrypted       = false
  vpc_security_group_ids  = [var.rds_security_group]
  db_subnet_group_name    = aws_db_subnet_group.rds_subnet_group.name
  multi_az                = false
  storage_type            = "gp2"
  publicly_accessible     = false
  backup_retention_period = 7
  skip_final_snapshot     = true
  apply_immediately       = true
}
