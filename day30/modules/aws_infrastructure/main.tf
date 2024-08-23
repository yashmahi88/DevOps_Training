resource "aws_vpc" "yashm_vpc" {
  cidr_block = "10.0.0.0/16"
  tags = {
    Name = "yashm-vpc"
  }
}

resource "aws_internet_gateway" "yashm_igw" {
  vpc_id = aws_vpc.yashm_vpc.id

  tags = {
    Name = "yashm-igw"
  }
}

resource "aws_route_table" "yashm_route_table" {
  vpc_id = aws_vpc.yashm_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.yashm_igw.id
  }

  tags = {
    Name = "yashm-route-table"
  }
}

resource "aws_route_table_association" "yashm_route_table_association" {
  subnet_id      = aws_subnet.yashm_subnet.id
  route_table_id = aws_route_table.yashm_route_table.id
}

resource "aws_subnet" "yashm_subnet" {
  cidr_block = "10.0.1.0/24"
  vpc_id     = aws_vpc.yashm_vpc.id
  availability_zone = "us-west-2a"
  map_public_ip_on_launch = true  # Ensure this is set to true
  tags = {
    Name = "yashm-subnet"
  }
}

resource "aws_security_group" "yashm_sg" {
  name        = "yashm-sg"
  description = "Security group for yashm instance"
  vpc_id      = aws_vpc.yashm_vpc.id

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]  # Allows SSH from anywhere
  }


  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_instance" "app_instance" {
  ami           = var.ami_id
  instance_type = var.instance_type
  key_name      = var.key_pair_name
  vpc_security_group_ids = [aws_security_group.yashm_sg.id]
  subnet_id     = aws_subnet.yashm_subnet.id
  associate_public_ip_address = true  # Ensure this is set to true
  connection {
      type        = "ssh"
      user        = "ubuntu"
      private_key = file("~/.ssh/example.pem")
      host        = self.public_ip
    }
  tags = {
    Name = "${var.name}-instance"
  }

  provisioner "remote-exec" {
    inline = [
      "sudo apt update -y",
      "sudo apt install -y apache2",
      "sudo systemctl start apache2",
      "sudo systemctl enable apache2"
    ]

  }

  provisioner "local-exec" {
    command = "echo 'EC2 instance successfully provisioned with Apache' > provision_status.txt"
  }
}

resource "aws_s3_bucket" "app_bucket" {
  bucket = var.bucket_name

  tags = {
    Name = "${var.name}-bucket"
  }
}

output "instance_public_ip" {
  value = aws_instance.app_instance.public_ip
}

output "bucket_arn" {
  value = aws_s3_bucket.app_bucket.arn
}
