variable "instance_name" {
  type        = string
  description = "The name of Ec2 instance"
}

variable "ami_id" {
  description = "AMI ID"
  type        = string # this is passed from terraform.tfvars
}

variable "instance_type" {
  description = "Instance type"
  type        = string
  default     = "t2.micro"
}

variable "tags" {
  description = "Tags"
  type        = map(string)
  default     = {}
}
variable "vpc_security_group_id" {
  description = "VPC security group ID"
  type        = string
}

variable "subnet_id" {
  description = "Subnet ID for the EC2 instance"
  type        = string
}

variable "has_public_ip" {
  description = "Whether to assign a public IP address to the instance"
  type        = bool
  default     = true
}

