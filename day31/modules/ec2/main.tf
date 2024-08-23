resource "aws_instance" "yashm_app" {
  count                    = var.instance_count
  ami                      = var.ami_id
  instance_type            = var.instance_type
  subnet_id                = element(var.public_subnet_ids, count.index)
  key_name                 = var.key_name
  associate_public_ip_address = true
  security_groups          = [var.security_group_id]

  tags = {
    Name = "yashm-app-instance-${count.index}"
  }
}
