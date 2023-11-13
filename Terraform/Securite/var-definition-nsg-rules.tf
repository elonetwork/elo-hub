
variable "resource_group_name" {
  type = string
}

variable "access-deny" {
  type = string
}

variable "access-allow" {
  type = string
}

variable "direction-inbound" {
  type = string
}

variable "direction-outbound" {
  type = string
}

variable "priority-1000" {
  type = number
}

variable "priority-100" {
  type = number
}

variable "priority-110" {
  type = number
}
variable "priority-200" {
  type = number
}

variable "value-etoile" {
  type = string
}

variable "name-deny-all-inbound-rule-bastion" {
  type = string
}

variable "name-allow-tcp-outbound-rule-bastion" {
  type = string
}

variable "name-allow-tcp-inbound-rule-bastion" {
  type = string
}

variable "name-deny-all-inbound-rule-squid" {
  type = string
}

variable "name-allow-tcp-inbound-rule-squid" {
  type = string
}

variable "name-nsg-http-allow-outbound-squid" {
  type = string
}

variable "name-nsg-https-allow-outbound-squid" {
  type = string
}

variable "name-nsg-deny-all-outbound-squid" {
  type = string
}

variable "port22" {
  type = string
}

variable "protocole-tcp" {
  type = string
}

variable "protocole-http" {
  type = string
}

variable "protocole-https" {
  type = string
}


