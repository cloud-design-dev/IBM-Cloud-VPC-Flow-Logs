output vpc_id {
  value = ibm_is_vpc.vpc.id
}


output subnet_id {
  value = ibm_is_subnet.subnet.id
}

output subnet_cidr {
  value = ibm_is_subnet.subnet.ipv4_cidr_block
}