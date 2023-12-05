variable "firewall_nat_rule_collection_name" {
  description = "Name of the NAT rule collection"
  type        = string
  default     = "nat_rule_collection"
}

variable "firewall_network_rule_collection_name" {
  description = "Name of the network rule collection"
  type        = string
  default     = "firewall_allow_traffic_network_collection"
}


variable "firewall_application_rule_collection_name" {
  description = "Name of the network rule collection"
  type        = string
  default     = "firewall_application_rule_collection"
}

variable "bastion_private_ip" {
  
}
variable "firewall_nat_protocols" {
  description = "Protocols for NAT rule collection"
  type        = list(string)
  default     = ["TCP", "UDP"]
}

variable "firewall_network_protocols" {
  description = "Protocols for network rule collection"
  type        = list(string)
  default     = ["TCP", "UDP"]
}
