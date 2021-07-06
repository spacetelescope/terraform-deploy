resource "aws_db_subnet_group" "db_subnet_group" {
  name       = "${var.cluster_name}-db-subnet-group"  
  subnet_ids = var.db_subnet_group_ids 
}

resource "aws_db_instance" "db_instance" {  
  identifier             = "${var.cluster_name}-db-instance"
  instance_class         = "db.t3.micro"
  allocated_storage      = 5  
  engine                 = "postgres"  
  engine_version         = "12.5"  
  username               = var.db_username 
  password               = var.db_password
  db_subnet_group_name   = aws_db_subnet_group.db_subnet_group.name  
  vpc_security_group_ids = var.vpc_security_group_ids  
  parameter_group_name   = aws_db_parameter_group.db_parameter_group.name
  publicly_accessible    = false 
  skip_final_snapshot    = true
}

resource "aws_db_parameter_group" "db_parameter_group" {
  name   = "${var.cluster_name}-parameter-group"
  family = "postgres12"
  parameter {    
    name  = "log_connections" 
    value = "1" 
  }
}
