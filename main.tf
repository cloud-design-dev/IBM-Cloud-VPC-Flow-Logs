module "vpc" {
  source            = "./vpc"
  resource_group_id = data.ibm_resource_group.group.id
  name              = var.basename
  tags              = var.tags
  zone              = data.ibm_is_zones.regional_zones.zones[0]
}

module "object_storage" {
  source            = "./object-storage"
  resource_group_id = data.ibm_resource_group.group.id
  region            = var.region
  name              = var.basename
  tags              = var.tags
}

# module "flow_logs" {
#   source            = "./flow-logs"
#   resource_group_id = data.ibm_resource_group.group.id
#   name              = var.basename
#   tags              = concat(var.tags, ["flow-logs"])
#   vpc_id            = module.vpc.id
#   instance_bucket   = module.object_storage.instance_bucket_id
#   subnet_bucket     = module.object_storage.subnet_bucket_id
#   vpc_bucket        = module.object_storage.vpc_bucket_id
# }