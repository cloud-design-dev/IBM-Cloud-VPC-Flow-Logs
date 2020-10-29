output web_instance_ips {
  value = module.webservers.web_instance_ips
}

output bastion_fip {
  value = module.bastion.bastion_fip
}