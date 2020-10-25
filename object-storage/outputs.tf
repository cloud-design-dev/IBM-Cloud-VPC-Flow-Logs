output "cos_id" {
  value = ibm_resource_instance.cos_instance.id
}

output "vpc_bucket_id" {
  value = ibm_cos_bucket.vpc_flow_logs.id
}

output "subnet_bucket_id" {
  value = ibm_cos_bucket.subnet_flow_logs.id
}

output "instance_bucket_id" {
  value = ibm_cos_bucket.instance_flow_logs.id
}