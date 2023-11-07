output "nsg-name" {
  value = azurerm_network_security_group.nsg_subnet.name
}

output "nsg-object" {
  value = azurerm_network_security_group.nsg_subnet
}