variable "resource_group_name" {
  type    = string
}

variable "location" {
  type    = string
}

variable "vnet_name" {
  type    = string
}

variable "firewal_name" {
  default = "firewall"
  type    = string
}

variable "bastion_vm_ip" {
    type    = string
}

