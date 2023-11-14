variable "resource_group_name" {
  type    = string
}

variable "location" {
  type    = string
}

variable "public_ip_firewall_name" {
  default = "public_ip_firewall"
}

variable "public_ip_firewall_mgmt_name" {
  default = "public_ip_firewall_mgmt"
}

variable "firewal_name" {
  default = "firewall"
  type    = string
}

variable "sub_firewall_id" {
}

variable "sub_firewall_mgm_id" {
}

variable "bastion_private_ip" {
}

variable "squid_private_ip" {
}