output "ec2_instance_ids" {
  value = flatten([for module_instance in module.my_ec2_module : module_instance.instance_ids])
}

output "s3_bucket_arns" {
  description = "ARNs of all S3 buckets"
  value       = flatten([for module_instance in module.my_s3_module : module_instance.bucket_arn])
}

