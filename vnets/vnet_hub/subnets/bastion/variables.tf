variable "subnet_name" {
  type = string
}

variable "resource_group_name" {
  description = "Name of the Resource Group"
}

variable "location" {
  description = "location of the Resource Group"
}

variable "address_prefixes" {
  type = list(string)
}

variable "vnet_name" {
}

variable "ssh_public_key" {
  type    = string
}
