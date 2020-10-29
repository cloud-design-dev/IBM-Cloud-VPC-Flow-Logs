output web_instance_ips {
  value = ibm_is_instance.web_instance[*].primary_network_interface[0].primary_ipv4_address
}