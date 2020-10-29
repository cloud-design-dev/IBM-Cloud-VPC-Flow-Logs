output "cos_id" {
  value = ibm_resource_instance.cos_instance.id
}

output "vpc_bucket" {
  value = ibm_cos_bucket.vpc_flow_logs.bucket_name
}

output "subnet_bucket" {
  value = ibm_cos_bucket.subnet_flow_logs.bucket_name
}

output "instance_bucket" {
  value = ibm_cos_bucket.instance_flow_logs.bucket_name
}