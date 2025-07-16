terraform {
  required_version = ">=1.12.0"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~>6.2"
    }
  }
  backend "s3" {
    bucket       = "sujan-terraform-state-bucket"
    region       = "us-east-1"
    encrypt      = true
    use_lockfile = true
    key          = "terraform-day-3/infrastructure.tfstate"
  }
}
