resource "aws_db_subnet_group" "yashm_db_subnet_group" {
  name       = "yashm-db-subnet-group"
  subnet_ids = [aws_subnet.private_subnet_a.id, aws_subnet.private_subnet_b.id]
  tags = {
    Name = "yashm-db-subnet-group"
  }
}

resource "aws_db_instance" "yashm_rds" {
  identifier           = "yashm-rds"
  engine               = "mysql"
  instance_class       = "db.t3.micro"
  allocated_storage    = 20
  username             = "admin"
  password             = var.db_password
  db_subnet_group_name = aws_db_subnet_group.yashm_db_subnet_group.name
  vpc_security_group_ids = [aws_security_group.db_sg.id]
  skip_final_snapshot  = true

  tags = {
    Name = "yashm-rds"
  }
}
