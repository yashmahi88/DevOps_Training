variable "db_username" {
  description = "Database username"
  type        = string
  
}

variable "db_password" {
  description = "Database password"
  type        = string
  
}

variable "private_subnet_ids" {
  description = "List of private subnet IDs"
  type        = list(string)
}

variable "vpc_id" {
  description = "ID of the VPC"
  type        = string
}
