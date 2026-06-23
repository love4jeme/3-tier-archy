# Security group for RDS
resource "aws_security_group" "rds_sg" {
  name        = "${var.project_name}-rds-sg"
  description = "Allow PostgreSQL from ASG instances only"
  vpc_id      = var.vpc_id

  ingress {
    description     = "PostgreSQL from ASG instances"
    from_port       = 5432
    to_port         = 5432
    protocol        = "tcp"
    security_groups = [var.asg_sg_id]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = merge(var.common_tags, { Name = "${var.project_name}-rds-sg" })
}

# RDS Subnet Group
resource "aws_db_subnet_group" "rds" {
  name       = "app-${var.project_name}-rds-subnet-group"
  subnet_ids = var.data_subnet_ids
  tags       = merge(var.common_tags, { Name = "${var.project_name}-rds-subnet-group" })
}

# RDS PostgreSQL Instance
resource "aws_db_instance" "postgres" {
  identifier        = "app-${var.project_name}-rds"
  engine            = "postgres"
  engine_version    = "15"
  instance_class    = "db.t3.micro"
  allocated_storage = 20
  storage_type      = "gp2"

  db_name  = "appdb"
  username = var.db_username
  password = var.db_password

  db_subnet_group_name   = aws_db_subnet_group.rds.name
  vpc_security_group_ids = [aws_security_group.rds_sg.id]

  multi_az               = true
  publicly_accessible    = false
  skip_final_snapshot    = true
  deletion_protection    = false

  tags = merge(var.common_tags, { Name = "${var.project_name}-rds" })
}
