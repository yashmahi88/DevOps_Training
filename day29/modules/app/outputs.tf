output "instance_public_ip" {
  description = "The public IP of the EC2 instance"
  value       = aws_instance.yashm_app_instance.public_ip
}

output "bucket_name" {
  description = "The name of the S3 bucket"
  value       = aws_s3_bucket.yashm_app_bucket.bucket
}

output "dynamodb_table_name" {
  description = "The name of the DynamoDB table"
  value       = aws_dynamodb_table.yashm_terraform_lock.name
}
