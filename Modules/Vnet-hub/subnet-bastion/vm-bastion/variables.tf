variable "name" {
  type = string
}

variable "location" {
  type = string
}

variable "resource_group_name" {
  type = string
}

variable "network_interface_ids" {
  type = list(any)
}

variable "public_key" {
  type = string
}