data "terraform_remote_state" "ec2" {
  backend = "s3"
  config = {
    bucket = "sujan-terraform-state-bucket"
    key    = "terraform.tfstate"
    region = "us-east-1"
  }
}

resource "aws_s3_bucket" "sujan_bucket" {
  bucket = "com-sujan-bucket"

  tags = {
    Name = "sujankarn-s3"
    Creator = "sujankarn"
  }
}

resource "aws_s3_bucket_policy" "policy" {
  bucket = aws_s3_bucket.sujan_bucket.id

  policy = <<POLICY
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Sid": "allowec2",
      "Effect": "Allow",
      "Principal": {
        "AWS": "${data.terraform_remote_state.ec2.outputs.ec2_instance_arn}"
      },
      "Action": "s3:PutObject",
      "Resource" : "${aws_s3_bucket.sujan_bucket.arn}/*"
    }
  ]
}
POLICY
}

