variable "nat_rule_collection-name" {
  type = string
}

variable "nat_rule_collection-priority" {
  type = string
}

variable "nat_rule_collection-action" {
  type = string
}

variable "nat_rule_collection-rule-name" {
  type = string
}

variable "nat_rule_collection-rule-source-addresses" {
  type = list(string)
}

variable "nat_rule_collection-rule-destination_ports" {
  type = list(string)
}

variable "nat_rule_collection-rule-translated_port" {
  type = number
}

variable "nat_rule_collection-rule-translated_address" {
  type = string
}

variable "nat_rule_collection-rule-protocols" {
  type = list(string)
}

variable "firewall_network_rule_collection-name" {
  type = string
}

variable "firewall_network_rule_collection-priority" {
  type = number
}

variable "firewall_network_rule_collection-action" {
  type = string
}

variable "firewall_network_rule_collection-rule-name" {
  type = string
}

variable "firewall_network_rule_collection-rule-source_addresses" {
  type = list(string)
}

variable "firewall_network_rule_collection-rule-destination_ports" {
  type = list(string)
}

variable "firewall_network_rule_collection-rule-destination_addresses" {
  type = list(string)
}

variable "firewall_network_rule_collection-rule-protocols" {
  type = list(string)
}


