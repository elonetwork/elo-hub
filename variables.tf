variable "resource_group_name" {
  type    = string
  default = "1-d00b0ff7-playground-sandbox"
}

variable "location" {
  type    = string
  default = "East US"
}

variable "vnet_name" {
  type    = string
  default = "vnet-hub"
}
variable "vnet_name_prod" {
  type    = string
  default = "vnet-hub"
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


