provider "aws" {
  region = var.region
}

# Security Group
resource "aws_security_group" "yashm_sg" {
  name        = "yashm-app-sg"
  description = "Allow SSH and other necessary ports"
  vpc_id      = var.vpc_id  # Use the existing VPC ID

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "yashm-app-sg"
  }
}

# Subnet
resource "aws_subnet" "yashm_subnet" {
  vpc_id            = var.vpc_id
  cidr_block        = "10.0.5.0/24"
  availability_zone =  "us-west-2a"  # Specify an availability zone within your region
  map_public_ip_on_launch = true
  tags = {
    Name = "yashm-subnet1"
  }
}



# EC2 Instance
resource "aws_instance" "yashm_app_instance" {
  ami           = var.ami_id
  instance_type = var.instance_type
  vpc_security_group_ids = [aws_security_group.yashm_sg.id]
  subnet_id     = aws_subnet.yashm_subnet.id
  tags = {
    Name = "yashm-app-instance"
  }
}

# S3 Bucket
resource "aws_s3_bucket" "yashm_app_bucket" {
  bucket = var.bucket_name
  acl    = "private"

  tags = {
    Name = "yashm-app-bucket"
  }
}

# DynamoDB Table for state locking
resource "aws_dynamodb_table" "yashm_terraform_lock" {
  name           = var.dynamodb_table_name
  read_capacity   = 1
  write_capacity  = 1
  hash_key        = "LockID"

  attribute {
    name = "LockID"
    type = "S"
  }

  tags = {
    Name = "yashm-terraform-lock-table"
  }
}
