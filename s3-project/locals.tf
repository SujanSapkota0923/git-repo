locals {
  common-tags = {
    Creator = "sujan sapkota"
  }
  role_arn = try(data.terraform_remote_state.ec2.outputs.ec2_role_arn, null)
}   