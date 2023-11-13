variable "name-vnet" {
  type    = string
  default = ""
}

variable "location" {
  type    = string
  default = ""
}

variable "resource_group_name" {
  type    = string
  default = ""
  
}

variable "address-space-vnet" {
  type = list(string)
  default = [""]
}



