output instance {
  value = ibm_is_instance.bastion_instance
}

output "bastion_fip" {
  value = ibm_is_floating_ip.bastion_ip.address
}

output bastion_private_ip {
  value = ibm_is_instance.bastion_instance.primary_network_interface.0.primary_ipv4_address
}