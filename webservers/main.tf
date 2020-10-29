resource ibm_is_security_group web_security_group {
  name           = "${var.name}-web-security-group"
  vpc            = var.vpc_id
  resource_group = var.resource_group_id
}

resource "ibm_is_security_group_rule" "ping" {
  group     = ibm_is_security_group.web_security_group.id
  direction = "inbound"
  remote    = "0.0.0.0/0"
  icmp {
    type = 8
  }
}

# from https://cloud.ibm.com/docs/vpc?topic=vpc-service-endpoints-for-vpc
resource "ibm_is_security_group_rule" "cse_dns_1" {
  group     = ibm_is_security_group.web_security_group.id
  direction = "outbound"
  remote    = "161.26.0.10"
  udp {
    port_min = 53
    port_max = 53
  }
}

resource "ibm_is_security_group_rule" "cse_dns_2" {
  group     = ibm_is_security_group.web_security_group.id
  direction = "outbound"
  remote    = "161.26.0.11"
  udp {
    port_min = 53
    port_max = 53
  }
}

resource "ibm_is_security_group_rule" "private_dns_1" {
  group     = ibm_is_security_group.web_security_group.id
  direction = "outbound"
  remote    = "161.26.0.7"
  udp {
    port_min = 53
    port_max = 53
  }
}

resource "ibm_is_security_group_rule" "private_dns_2" {
  group     = ibm_is_security_group.web_security_group.id
  direction = "outbound"
  remote    = "161.26.0.8"
  udp {
    port_min = 53
    port_max = 53
  }
}

resource "ibm_is_security_group_rule" "outbound_http" {
  group     = ibm_is_security_group.web_security_group.id
  direction = "outbound"
  remote    = "0.0.0.0/0"
  tcp {
    port_min = 80
    port_max = 80
  }
}

resource "ibm_is_security_group_rule" "inbound_http" {
  group     = ibm_is_security_group.web_security_group.id
  direction = "inbound"
  remote    = "0.0.0.0/0"
  tcp {
    port_min = 80
    port_max = 80
  }
}

resource "ibm_is_security_group_rule" "inbound_https" {
  group     = ibm_is_security_group.web_security_group.id
  direction = "inbound"
  remote    = "0.0.0.0/0"
  tcp {
    port_min = 443
    port_max = 443
  }
}

resource "ibm_is_security_group_rule" "outbound_https" {
  group     = ibm_is_security_group.web_security_group.id
  direction = "outbound"
  remote    = "0.0.0.0/0"
  tcp {
    port_min = 443
    port_max = 443
  }
}

resource "ibm_is_security_group_rule" "ssh_in" {
  group     = ibm_is_security_group.web_security_group.id
  direction = "inbound"
  remote    = var.bastion_private_ip
  tcp {
    port_min = 22
    port_max = 22
  }
}

resource "ibm_is_instance" "web_instance" {
  count          = 3
  name           = "${var.name}-web${count.index + 1}-instance"
  vpc            = var.vpc_id
  zone           = var.zone
  profile        = var.profile_name
  image          = data.ibm_is_image.image.id
  keys           = [data.ibm_is_ssh_key.sshkey.id]
  resource_group = var.resource_group_id

  # inject dns config
  user_data = file("${path.module}/web-init.sh")

  primary_network_interface {
    subnet          = var.subnet_id
    security_groups = [ibm_is_security_group.web_security_group.id]
  }

  boot_volume {
    name = "${var.name}-web${count.index + 1}-boot"
  }

  tags = concat(var.tags, ["webserver"])
}