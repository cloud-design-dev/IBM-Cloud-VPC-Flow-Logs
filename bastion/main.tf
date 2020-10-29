resource ibm_is_security_group bastion_security_group {
  name           = "${var.name}-bastion-security-group"
  vpc            = var.vpc_id
  resource_group = var.resource_group_id
}

resource "ibm_is_security_group_rule" "ping" {
  group     = ibm_is_security_group.bastion_security_group.id
  direction = "inbound"
  remote    = "0.0.0.0/0"
  icmp {
    type = 8
  }
}

# from https://cloud.ibm.com/docs/vpc?topic=vpc-service-endpoints-for-vpc
resource "ibm_is_security_group_rule" "cse_dns_1" {
  group     = ibm_is_security_group.bastion_security_group.id
  direction = "outbound"
  remote    = "161.26.0.10"
  udp {
    port_min = 53
    port_max = 53
  }
}

resource "ibm_is_security_group_rule" "cse_dns_2" {
  group     = ibm_is_security_group.bastion_security_group.id
  direction = "outbound"
  remote    = "161.26.0.11"
  udp {
    port_min = 53
    port_max = 53
  }
}

resource "ibm_is_security_group_rule" "private_dns_1" {
  group     = ibm_is_security_group.bastion_security_group.id
  direction = "outbound"
  remote    = "161.26.0.7"
  udp {
    port_min = 53
    port_max = 53
  }
}

resource "ibm_is_security_group_rule" "private_dns_2" {
  group     = ibm_is_security_group.bastion_security_group.id
  direction = "outbound"
  remote    = "161.26.0.8"
  udp {
    port_min = 53
    port_max = 53
  }
}

resource "ibm_is_security_group_rule" "inbound_from_cidr" {
  group     = ibm_is_security_group.bastion_security_group.id
  direction = "inbound"
  remote    = var.subnet_cidr
}

resource "ibm_is_security_group_rule" "outbound_to_cidr" {
  group     = ibm_is_security_group.bastion_security_group.id
  direction = "outbound"
  remote    = var.subnet_cidr
}

resource "ibm_is_security_group_rule" "ssh_in" {
  group     = ibm_is_security_group.bastion_security_group.id
  direction = "inbound"
  remote    = var.remote_ip
  tcp {
    port_min = 22
    port_max = 22
  }
}

resource "ibm_is_instance" "bastion_instance" {
  name           = "${var.name}-bastion-instance"
  vpc            = var.vpc_id
  zone           = var.zone
  profile        = var.profile_name
  image          = data.ibm_is_image.image.id
  keys           = [data.ibm_is_ssh_key.sshkey.id]
  resource_group = var.resource_group_id

  # inject dns config
  user_data = file("${path.module}/init.sh")

  primary_network_interface {
    subnet          = var.subnet_id
    security_groups = [ibm_is_security_group.bastion_security_group.id]
  }

  boot_volume {
    name = "${var.name}-bastion-boot"
  }

  tags = concat(var.tags, ["bastion"])
}


resource "ibm_is_floating_ip" "bastion_ip" {
  name           = "${var.name}-bastion-fip"
  target         = ibm_is_instance.bastion_instance.primary_network_interface.0.id
  resource_group = var.resource_group_id
}