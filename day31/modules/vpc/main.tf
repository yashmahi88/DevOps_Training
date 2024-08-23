resource "aws_vpc" "yashm_vpc" {
  cidr_block = var.cidr_block
  enable_dns_support = true
  enable_dns_hostnames = true
  tags = {
    Name = "yashm-main-vpc"
  }
}

resource "aws_subnet" "yashm_public" {
  count = length(var.public_subnet_cidrs)
  vpc_id = aws_vpc.yashm_vpc.id
  cidr_block = element(var.public_subnet_cidrs, count.index)
  availability_zone = element(var.availability_zones, count.index)
  map_public_ip_on_launch = true
  tags = {
    Name = "yashm-public-subnet-${count.index}"
  }
}

resource "aws_subnet" "yashm_private" {
  count = length(var.private_subnet_cidrs)
  vpc_id = aws_vpc.yashm_vpc.id
  cidr_block = element(var.private_subnet_cidrs, count.index)
  availability_zone = element(var.availability_zones, count.index)
  tags = {
    Name = "yashm-private-subnet-${count.index}"
  }
}

resource "aws_internet_gateway" "yashm_igw" {
  vpc_id = aws_vpc.yashm_vpc.id
  tags = {
    Name = "yashm-main-igw"
  }
}

resource "aws_route_table" "yashm_public" {
  vpc_id = aws_vpc.yashm_vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.yashm_igw.id
  }
  tags = {
    Name = "yashm-public-route-table"
  }
}

resource "aws_route_table_association" "yashm_public" {
  count = length(aws_subnet.yashm_public)
  subnet_id = element(aws_subnet.yashm_public.*.id, count.index)
  route_table_id = aws_route_table.yashm_public.id
}
