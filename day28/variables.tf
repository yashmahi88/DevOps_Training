variable "existing_vpc_id" {
  description = "The ID of the existing VPC"
  type        = string
  default     = "vpc-028be68f6a49a5a7c"
}

variable "existing_igw_id" {
  description = "The ID of the existing Internet Gateway"
  type        = string
  default     = "igw-09e8ebb5b3a4e49c9"
}

variable "key_name" {
  description = "The name of the existing SSH key pair"
  type        = string
  default     = "yashm-28"  # Replace with your default key pair name
}

variable "aws_region" {
  description = "AWS region for deployment"
  default     = "us-west-2"
}

variable "ami_id" {
  description = "AMI ID for the EC2 instance"
  default     = "ami-0aff18ec83b712f05"  # Replace with Ubuntu AMI for your region specified
}

variable "instance_type" {
  description = "Instance type for the EC2 instance"
  default     = "t2.micro"
}

variable "db_instance_class" {
  description = "Instance class for the RDS MySQL database"
  default     = "db.t3.micro"
}

variable "db_name" {
  description = "Name of the MySQL database"
  default     = "yashm04"
}

variable "db_username" {
  description = "Username for the MySQL database"
  default     = "root"
}

variable "db_password" {
  description = "Password for the MySQL database"
  default     = "password"  # Choose a strong password
}

variable "bucket_name" {
  description = "Name of the S3 bucket"
  default     = "yashmahi-bucket-0404"
}
