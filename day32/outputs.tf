output "vpc_id" {
  value = aws_vpc.yashm_vpc.id
}

output "public_subnet_ids" {
  value = [aws_subnet.public_subnet_a.id, aws_subnet.public_subnet_b.id]
}

output "private_subnet_ids" {
  value = [aws_subnet.private_subnet_a.id, aws_subnet.private_subnet_b.id]
}

output "rds_endpoint" {
  value = aws_db_instance.yashm_rds.endpoint
}

output "ecs_cluster_name" {
  value = aws_ecs_cluster.yashm_ecs_cluster.name
}
