variable "name-subnet-bastion" {
  type    = string
}

variable "address-prefixes-subnet-bastion" {
  type = list(string)
}

variable "name-subnet-firewall" {
  type    = string
}

variable "address-prefixes-subnet-firewall" {
  type = list(string)
}

variable "name-subnet-squid" {
  type    = string
}

variable "address-prefixes-subnet-squid" {
  type = list(string)

}

variable "name-subnet-firewall-mgm" {
  type = string
}

variable "address-prefixes-subnet-firewall-mgm" {
  type = list(string)
}


