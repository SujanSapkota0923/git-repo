resource "aws_iam_role" "ec2_role" {
  name = "sujan-ec2-s3-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [{
      Effect = "Allow",
      Principal = {
        Service = "ec2.amazonaws.com"
      },
      Action = "sts:AssumeRole"
    }]
  })
}

resource "aws_iam_instance_profile" "ec2_profile" {
  name = "sujan-ec2-profile"
  role = aws_iam_role.ec2_role.name
}

resource "aws_instance" "ec2" {
  ami           = "ami-0150ccaf51ab55a51"
  key_name = "sujan-sapkota-keypair-for-ssh-ec2-instane"
  instance_type = "t2.micro"
  subnet_id     = "subnet-0fdfb5252ab10392f"
  vpc_security_group_ids = ["sg-004d2faf4052a0c12"]
  iam_instance_profile        = aws_iam_instance_profile.ec2_profile.name
  associate_public_ip_address = true

  tags = {
    Name = "sujankarn-ec2"
    Creator = "sujansapkota"
  }
}