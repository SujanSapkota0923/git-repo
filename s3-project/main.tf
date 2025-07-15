terraform {
  backend "s3" {
    bucket       = "com.sujan-sapkota-lf-terraform-state-bucket"
    key          = "s3-instance/terraform.tfstate"
    region       = "us-east-1"
    use_lockfile = true
  }

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 6.0"
    }
  }
}

data "terraform_remote_state" "ec2" {
  backend = "s3"
  config = {
    bucket = "com.sujan-sapkota-lf-terraform-state-bucket"
    key    = "ec2-instance/terraform.tfstate"
    region = "us-east-1"
  }
}

    
provider "aws" {
  region = "us-east-1"
}

resource "aws_s3_bucket" "mybucket" {
  bucket        = "com.sujan-sapkota-lf-bucket"
  force_destroy = true

  tags = merge(local.common-tags, { Name : "sujan-sapkota-tf-bucket" })
}

resource "aws_s3_bucket_versioning" "versioning_sujan" {
  bucket = aws_s3_bucket.mybucket.id
  versioning_configuration {
    status = "Enabled"
  }
}

resource "aws_s3_bucket_policy" "write_ec2" {
  count  = local.role_arn != null ? 1 : 0
  bucket = aws_s3_bucket.mybucket.id
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Principal = {
          AWS = local.role_arn
        }
        Action = [
          "s3:PutObject",
        ]
        Resource = "${aws_s3_bucket.mybucket.arn}/*"
      }
    ]
  })
}

# changes