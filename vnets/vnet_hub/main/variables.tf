variable "resource_group_name" {
  type    = string
}

variable "location" {
  type    = string
}

variable "vnet_name" {
  type    = string
}


variable "bastion_subnet_name" {
  type    = string
  default = "sub-bastion"
}

variable "squide_subnet_name" {
  type    = string
  default = "sub-squide"
}

variable "firewal_name" {
  type    = string
  default = "sub_firewal"
}

variable "ssh_public_key" {
  type    = string
}
