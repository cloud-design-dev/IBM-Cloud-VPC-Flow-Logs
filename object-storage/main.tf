
resource "ibm_resource_instance" "cos_instance" {
  name              = "${var.name}-cos-instance"
  resource_group_id = var.resource_group_id
  service           = "cloud-object-storage"
  plan              = "standard"
  location          = "global"
  tags              = concat(var.tags, ["object-storage"])
}

resource "ibm_cos_bucket" "vpc_flow_logs" {
  bucket_name          = "${var.name}-${var.region}-vpc-flowlogs-bucket"
  resource_instance_id = ibm_resource_instance.cos_instance.id
  region_location      = var.region
  storage_class        = "smart"
}

resource "ibm_cos_bucket" "subnet_flow_logs" {
  bucket_name          = "${var.name}-${var.region}-subnet-flowlogs-bucket"
  resource_instance_id = ibm_resource_instance.cos_instance.id
  region_location      = var.region
  storage_class        = "smart"
}

resource "ibm_cos_bucket" "instance_flow_logs" {
  bucket_name          = "${var.name}-${var.region}-instance-flowlogs-bucket"
  resource_instance_id = ibm_resource_instance.cos_instance.id
  region_location      = var.region
  storage_class        = "smart"
}