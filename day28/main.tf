provider "aws" {
  region = var.aws_region
}

# Data source for existing Internet Gateway
data "aws_internet_gateway" "existing" {
  filter {
    name   = "attachment.vpc-id"
    values = [var.existing_vpc_id]
  }
}

# Data source for existing Key Pair
data "aws_key_pair" "existing" {
  key_name = var.key_name
}

# Create Subnets
resource "aws_subnet" "public_1" {
  vpc_id                  = var.existing_vpc_id
  cidr_block              = "10.0.7.0/24"
  availability_zone       = "us-west-2a"
  map_public_ip_on_launch = true
  tags = {
    Name = "YashM-Public-1"
  }
}

resource "aws_subnet" "public_2" {
  vpc_id                  = var.existing_vpc_id
  cidr_block              = "10.0.8.0/24"
  availability_zone       = "us-west-2b"
  map_public_ip_on_launch = true
  tags = {
    Name = "YashM-Public-2"
  }
}

# Create Route Table
resource "aws_route_table" "public" {
  vpc_id = var.existing_vpc_id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = data.aws_internet_gateway.existing.id
  }

  tags = {
    Name = "YashM-Public-Route-Table"
  }
}

# Associate Route Tables with Subnets
resource "aws_route_table_association" "public_1" {
  subnet_id      = aws_subnet.public_1.id
  route_table_id = aws_route_table.public.id
}

resource "aws_route_table_association" "public_2" {
  subnet_id      = aws_subnet.public_2.id
  route_table_id = aws_route_table.public.id
}

# Create Security Groups
resource "aws_security_group" "ec2_sg" {
  vpc_id = var.existing_vpc_id

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_security_group" "rds_sg" {
  vpc_id = var.existing_vpc_id

  ingress {
    from_port   = 3306
    to_port     = 3306
    protocol    = "tcp"
    security_groups = [aws_security_group.ec2_sg.id]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# Create EC2 Instance
resource "aws_instance" "app_server" {
  ami           = var.ami_id
  instance_type = var.instance_type
  subnet_id     = aws_subnet.public_1.id
  vpc_security_group_ids = [aws_security_group.ec2_sg.id]
  key_name      = data.aws_key_pair.existing.key_name

  tags = {
    Name = "YashM-Inst-01"
  }
}

# Create RDS Instance
resource "aws_db_instance" "mysql_db" {
  allocated_storage    = 20
  storage_type         = "gp2"
  engine               = "mysql"
  engine_version       = "8.0"
  instance_class       = var.db_instance_class
  db_name              = var.db_name
  username             = var.db_username
  password             = var.db_password
  publicly_accessible  = true
  vpc_security_group_ids = [aws_security_group.rds_sg.id]
  db_subnet_group_name = aws_db_subnet_group.main.name
  skip_final_snapshot = true
  tags = {
    Name = "YashM-DB-01"
  }
}

# Create S3 Bucket
resource "aws_s3_bucket" "my_bucket" {
  bucket = var.bucket_name
}



resource "aws_s3_bucket_versioning" "my_bucket_versioning" {
  bucket = aws_s3_bucket.my_bucket.id

  versioning_configuration {
    status = "Enabled"  # Enable versioning
  }
}

# Create DB Subnet Group
resource "aws_db_subnet_group" "main" {
  name       = "main"
  subnet_ids = [aws_subnet.public_1.id, aws_subnet.public_2.id]
  tags = {
    Name = "YashM-DB-Subnet-Group"
  }
}

output "ec2_public_ip" {
  value = aws_instance.app_server.public_ip
}

output "rds_endpoint" {
  value = aws_db_instance.mysql_db.endpoint
}

output "s3_bucket_name" {
  value = aws_s3_bucket.my_bucket.bucket
}
