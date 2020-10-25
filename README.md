# VPC Flow Logs Example 

This respository will deploy the following on IBM Cloud:
 - An [Object Storage]() instance.
 - A [VPC]() 
 - A [Bastion host]() that will allow us to run Ansible playbooks against private network only web instances. 
 - Three web instances
 - Three Object Storage [buckets]() that will be used to collect VPC flow logs at the VPC, Subnet, and Instance level. 
 - [Flow log collectors]() to collect logs at the VPC, Subnet, and Instance level.
 - An Ansible inventory file
 - Dynamically created Ansible playbooks for installing and configuring:
    - Wireguard VPN Server on the bastion host
    - Apache on the web hosts

## Current State:
 - [ ] Deploy VPC with the following resources:
    - [ ] A bastion security group that will allow SSH from a single IP address for running our Wireguard Ansible playbook
    - [ ] A web instance security group to allow outbound HTTP/HTTPS traffic
 - [ ] An Object Storage instance with the following buckets:
    - [ ] VPC flow logs bucket 
    - [ ] Subnet flow logs bucket 
    - [ ] Bastion instance flow logs bucket 
 - Flow Log Collector instance with the following flow logs configured:
    - [ ] Collector at the VPC Level pointed to the VPC flow logs bucket
    - [ ] Collector at the Subnet level pointed to the Subnet flow logs bucket
    - [ ] Collector at the Instance level pointed to the Bastion instance flow logs bucket
 - [ ] Bastion instance
 - [ ] Web Instances
 - [ ] Dynamically generated Ansible inventory file 
 - [ ] Dynamically generated Ansible Playbooks