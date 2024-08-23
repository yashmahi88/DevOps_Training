output "vpc_id" {
  value = aws_vpc.yashm_vpc.id
}

output "public_subnet_ids" {
  value = aws_subnet.yashm_public[*].id
}

output "private_subnet_ids" {
  value = aws_subnet.yashm_private[*].id
}
