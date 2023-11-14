output "nsg_id" {
  value = azurerm_network_security_group.elo-network.id
  description = "ID of nsg from the module"
}

output "nsg_name" {
  value = azurerm_network_security_group.elo-network.name
  description = "Name of nsg from the module"
}