terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.10"
    }
  }
  backend "s3" {
    bucket = "sujan-terraform-state-bucket"
    key    = "terraform.tfstate"
    region = "us-east-1"
  }
  required_version = ">= 1.12"
}

provider "aws" {
  region = "us-east-1"
}