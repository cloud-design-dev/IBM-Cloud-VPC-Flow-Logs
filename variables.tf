variable "region" {
  type        = string
  description = "The region where the VPC resources will be deployed."
  default     = "au-syd"
}

variable "resource_group" {
  default = "CDE"
}

variable "basename" {
  default = "flowlogexample"
}

variable "tags" {
  default = ["terraform", "ryantiffany"]
}

variable "remote_ip" {
  description = "Remote IP that will be allowed to access Bastion host."
  type        = string
  default     = "73.32.92.84"

}

variable "ssh_key_name" {
  default = "hyperion-au-syd"
}

variable "ibmcloud_timeout" {
  default = 900
}