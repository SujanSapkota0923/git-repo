provider "aws" {
  region = "us-east-1"
}


module "my_ec2_module" {
  source                = "./modules/ec2-module"
  instance_type         = local.current.ec2.instance_type
  ami_id                = var.ami_id
  subnet_id             = var.subnet_id
  instance_name         = "my-ec2-instance-${terraform.workspace}"
  vpc_security_group_id = var.vpc_security_group_id
  tags                  = local.tags
  has_public_ip         = local.current.ec2.has_public_ip

}

module "my_s3_module" {
  source                     = "./modules/s3-module"
  bucket_name                = "my-s3-bucket-sujan-${terraform.workspace}-${count.index}"
  tags                       = local.tags
  versioning_enabled         = local.current.s3.versioning_enabled
  allow_access_from_anywhere = local.current.s3.allow_access_from_anywhere
  region                     = local.region
}

