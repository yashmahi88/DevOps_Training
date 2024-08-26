provider "aws" {
  region = "us-west-2"
}

variable "ami_id" {
  default = "ami-0aff18ec83b712f05"
}

variable "db_password" {
  type      = string
  sensitive = true
}