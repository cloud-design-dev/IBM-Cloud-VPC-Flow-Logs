# VPC Flow Logs Example 

This respository will deploy the following on IBM Cloud:
 - An [Object Storage](https://cloud.ibm.com/docs/cloud-object-storage?topic=cloud-object-storage-about-cloud-object-storage) instance.
 - A [VPC](https://cloud.ibm.com/docs/vpc?topic=vpc-about-vpc) 
 - A [Bastion host]() that will allow us to run Ansible playbooks against private network only web instances. A Bastion host is an instance that is provisioned with a Floating Public IP address and can be accessed via SSH. Once set up, the bastion host acts as a jump server allowing secure connection to instances provisioned without a public IP address.
 - Three web instances running the Apache webserver
 - Three Object Storage buckets that will be used to collect VPC flow logs at the VPC, Subnet, and Instance level.
 - [Flow log collectors](https://cloud.ibm.com/docs/vpc?topic=vpc-flow-logs) to collect logs at the VPC, Subnet, and Instance level.
 - An Ansible inventory file
 - Dynamically created Ansible playbooks for installing and configuring:
    - Wireguard VPN Server on the bastion host
    - Apache on the web hosts

## To use this code:

```shell
git clone 

```

2. Update `.tfvars` file to match deployment. 

```
cp terraform.tfvars.template terraform.tfvars
```

## Current State:
 - [x] Deploy VPC with the following resources:
    - [x] A bastion security group that will allow SSH from a single IP address for running our Wireguard Ansible playbook
    - [x] A web instance security group to allow outbound HTTP/HTTPS traffic
    - [x] A bastion compute instance that will be used to communicate with webservers
    - [x] 3 Webservers with Apache installed
 - [x] An Object Storage instance with the following buckets:
    - [x] VPC flow logs bucket 
    - [x] Subnet flow logs bucket 
    - [x] Bastion instance flow logs bucket 
 - [x] Flow Log Collector instance with the following flow logs configured:
    - [x] Collector at the VPC Level pointed to the VPC flow logs bucket
    - [x] Collector at the Subnet level pointed to the Subnet flow logs bucket
    - [x] Collector at the Instance level pointed to the Bastion instance flow logs bucket
 - [ ] Dynamically generated Ansible inventory file 
 - [ ] Dynamically generated Ansible Playbooks