provider "aws" {
  region = "us-west-2"
  profile = var.aws_profile
}

terraform {
  backend "s3" {
    bucket         = "yashm-bucket"
    key            = "terraform/state.tfstate"
    region         = "us-west-2"
    dynamodb_table = "yashm_terraform_lock-table"
    #profile        = "prod"
    encrypt        = true
  }
}

module "vpc" {
  source = "./modules/vpc"
  cidr_block = var.vpc_cidr
  public_subnet_cidrs = var.public_subnet_cidrs
  private_subnet_cidrs = var.private_subnet_cidrs
  availability_zones = var.availability_zones
}

module "ec2" {
  source = "./modules/ec2"
  ami_id = var.ami_id
  instance_type = var.instance_type
  instance_count = 2
  public_subnet_ids = module.vpc.public_subnet_ids
  key_name = "example"
  security_group_id = module.security_group.sg_id
}

module "rds" {
  source = "./modules/rds"
  db_username = var.db_username
  db_password = var.db_password
  private_subnet_ids = module.vpc.private_subnet_ids
  vpc_id = module.vpc.vpc_id
}

#module "s3" {
#  source = "./modules/s3"
#  bucket_prefix = var.s3_bucket_prefix
#}

module "security_group" {
  source = "./modules/security_group"
  vpc_id = module.vpc.vpc_id
}


#resource "aws_dynamodb_table" "yashm_terraform_lock" {
#  name           = "yashm_terraform_lock-table"
#  read_capacity   = 5
#  write_capacity  = 5
#  hash_key        = "LockID"
#
#  attribute {
#    name = "LockID"
#    type = "S"
#  }

#  tags = {
#    Name = "yashm-terraform-lock-table"
#  }
#}