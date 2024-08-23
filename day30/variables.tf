variable "instance_type" {
  description = "EC2 instance type"
  type        = string
  default     = "t2.micro"
}

variable "ami_id" {
  description = "AMI ID for EC2"
  type        = string
}

variable "key_pair_name" {
  description = "Key pair name for SSH"
  type        = string
  default     = "example.pem"

}

variable "bucket_name" {
  description = "S3 bucket name"
  type        = string
  default     = "yashm-bucket"
}

variable "private_key" {
  description = "Path to SSH private key"
  type        = string
  default     = "./example"
}

variable "name" {
  description = "Name prefix for resources"
  type        = string
}
