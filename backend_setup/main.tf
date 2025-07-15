terraform {
    required_providers {
        aws = {
        source  = "hashicorp/aws"
        }
    }
    
}

provider "aws" {
  region = "us-east-1"  
}

resource "aws_s3_bucket" "terraform_state_bucket" {
  bucket = "com.sujan-sapkota-lf-terraform-state-bucket"
   object_lock_enabled = true

  tags = {
    Name = "terraform state bucket"
    Creator = "Sujan Sapkota"
  }
  
}

resource "aws_s3_bucket_versioning" "bucket_versioning_sujan-lf" {
  bucket = aws_s3_bucket.terraform_state_bucket.id
  versioning_configuration {
    status = "Enabled"
  }
}
