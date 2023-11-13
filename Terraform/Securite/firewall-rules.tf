resource "azurerm_firewall_nat_rule_collection" "nat_rule_collection" {
  name                = var.nat_rule_collection-name
  priority            = var.nat_rule_collection-priority
  azure_firewall_name = azurerm_firewall.firewall.name
  action              = var.nat_rule_collection-action
  resource_group_name = var.resource_group_name

  rule {
    name = var.nat_rule_collection-rule-name
    source_addresses = var.nat_rule_collection-rule-source-addresses
    destination_ports =var.nat_rule_collection-rule-destination_ports
    destination_addresses = [module.public_ip_firwall.publicip_object.ip_address]
    translated_port = var.nat_rule_collection-rule-translated_port
    translated_address = var.nat_rule_collection-rule-translated_address
    protocols = var.nat_rule_collection-rule-protocols
  }
}

resource "azurerm_firewall_network_rule_collection" "firewall_allow_traffic" {
  name                = var.firewall_network_rule_collection-name
  azure_firewall_name = azurerm_firewall.firewall.name
  resource_group_name = var.resource_group_name
  priority            = var.firewall_network_rule_collection-priority
  action              = var.firewall_network_rule_collection-action

  rule {
    name = var.firewall_network_rule_collection-rule-name
    source_addresses = var.firewall_network_rule_collection-rule-source_addresses
    destination_ports = var.firewall_network_rule_collection-rule-destination_ports
    destination_addresses = var.firewall_network_rule_collection-rule-destination_addresses
    protocols = var.firewall_network_rule_collection-rule-protocols
  }
}