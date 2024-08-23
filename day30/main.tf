terraform {
  backend "s3" {
    bucket         = "yashm-bucket-name"           # Your S3 bucket for state
    key            = "terraform/state"             # Path within the bucket
    region         = "us-west-2"                    # AWS region
    dynamodb_table = "yashm-terraform-lock"         # DynamoDB table for state locking
  }
}

provider "aws" {
  region = "us-west-2"  # Replace with your preferred region
}

module "aws_infrastructure" {
  source           = "./modules/aws_infrastructure"
  instance_type    = var.instance_type
  ami_id            = var.ami_id
  key_pair_name     = "example"
  bucket_name       = var.bucket_name
  private_key  = "${path.root}/example"  # Path to your private key file
  name              = var.name
}

output "instance_public_ip" {
  value = module.aws_infrastructure.instance_public_ip
}

output "bucket_arn" {
  value = module.aws_infrastructure.bucket_arn
}
