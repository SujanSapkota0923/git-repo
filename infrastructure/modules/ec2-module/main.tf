locals {
  tags = merge(var.tags, {
    Name = var.instance_name
  })
}
resource "aws_instance" "ec2_instance" {
  ami                         = var.ami_id
  instance_type               = var.instance_type
  tags                        = merge(local.tags)
  subnet_id                   = var.subnet_id
  vpc_security_group_ids      = [var.vpc_security_group_id]
  associate_public_ip_address = var.has_public_ip
}
