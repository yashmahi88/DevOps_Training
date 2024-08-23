output "instance_ids" {
  value = aws_instance.yashm_app[*].id
}
