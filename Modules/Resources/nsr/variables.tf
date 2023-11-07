variable "name" {
  type = string
}

variable "priority" {
  type = number
}

variable "direction" {
  type = string
}

variable "access" {
  type = string
}

variable "protocol" {
  type = string
  default = "*"
}

variable "source_port_range" {
  type = string
   default = "*"
}

variable "destination_port_range" {
  type = string
   default = "*"
}

variable "source_address_prefix" {
  type = string
   default = "*"
}

variable "destination_address_prefix" {
  type = string
   default = "*"
}

variable "resource_group_name" {
  type = string
}

variable "network_security_group_name" {
  type = string
}
