terraform {
  backend "s3" {
    bucket         = "yashm-application-bucket"   # Replace with your S3 bucket name
    key            = "terraform/state.tfstate"         # Path within the bucket
    region         = "us-west-2"                       # AWS region
    dynamodb_table = "yashm-terraform-lock-table"      # DynamoDB table for locking
  }
}

provider "aws" {
  region = "us-west-2"  # Replace with your AWS region
}

module "yashm_app" {
  source                = "./modules/app"
  region                = "us-west-2"  # Replace with your AWS region
  instance_type         = "t2.micro"
  bucket_name           = "yashm-application-bucket"  # Replace with a unique bucket name
  dynamodb_table_name   = "yashm-terraform-lock-table"  # Replace with a unique table name
  vpc_id                = "vpc-0bdf66d2ee59d250a"
  availability_zone     = "us-west-2a"
  ami_id                = "ami-0aff18ec83b712f05"  # Replace with the AMI ID for your region
}

output "instance_public_ip" {
  value = module.yashm_app.instance_public_ip
}

output "bucket_name" {
  value = module.yashm_app.bucket_name
}

output "dynamodb_table_name" {
  value = module.yashm_app.dynamodb_table_name
}
