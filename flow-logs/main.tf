resource ibm_is_flow_log vpc_flowlog {
  name           = "${var.name}-vpc-flow-log"
  target         = var.vpc_id
  active         = true
  storage_bucket = var.vpc_bucket
}


resource ibm_is_flow_log subnet_flowlog {
  name           = "${var.name}-subnet-flow-log"
  target         = var.subnet_id
  active         = true
  storage_bucket = var.subnet_bucket
}

resource ibm_is_flow_log instance_flowlog {
  name           = "${var.name}-instance-flow-log"
  target         = var.instance_id
  active         = true
  storage_bucket = var.instance_bucket
}