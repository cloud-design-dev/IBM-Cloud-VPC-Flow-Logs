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

module "bastion" {
  source            = "./bastion"
  resource_group_id = data.ibm_resource_group.group.id
  name              = var.basename
  tags              = var.tags
  zone              = data.ibm_is_zones.regional_zones.zones[0]
  vpc_id            = module.vpc.vpc_id
  subnet_id         = module.vpc.subnet_id
  subnet_cidr       = module.vpc.subnet_cidr
  ssh_key_name      = var.ssh_key_name
  remote_ip         = var.remote_ip
}

module "webservers" {
  source             = "./webservers"
  resource_group_id  = data.ibm_resource_group.group.id
  name               = var.basename
  tags               = var.tags
  zone               = data.ibm_is_zones.regional_zones.zones[0]
  vpc_id             = module.vpc.vpc_id
  subnet_id          = module.vpc.subnet_id
  bastion_private_ip = module.bastion.bastion_private_ip
  ssh_key_name       = var.ssh_key_name
}


module "flow_logs" {
  depends_on        = [module.object_storage]
  source            = "./flow-logs"
  resource_group_id = data.ibm_resource_group.group.id
  name              = var.basename
  tags              = concat(var.tags, ["flow-logs"])
  vpc_id            = module.vpc.vpc_id
  subnet_id         = module.vpc.subnet_id
  instance_id       = module.bastion.instance.id
  instance_bucket   = module.object_storage.instance_bucket
  subnet_bucket     = module.object_storage.subnet_bucket
  vpc_bucket        = module.object_storage.vpc_bucket
}