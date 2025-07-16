locals {
  config = {
    dev = {
      s3 = {
        versioning_enabled         = false
        allow_access_from_anywhere = true
        counts                     = 1
      },
      ec2 = {
        instance_type = "t2.micro"
        counts        = 1
        has_public_ip = false

      }
    },
    prod = {
      s3 = {
        versioning_enabled         = true
        allow_access_from_anywhere = false
        counts                     = 2
      },
      ec2 = {
        instance_type = "t2.micro"
        counts        = 1
        has_public_ip = false
      }
    }
  }

  current = lookup(local.config, terraform.workspace, {})

  tags = {
    Creator     = "Sujan Sapkota"
    Environment = terraform.workspace
  }
  region = "us-east-1"
}
