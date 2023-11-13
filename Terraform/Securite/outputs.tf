output "firewall_name" {
  value = azurerm_firewall.firewall.name
}

output "firewall_object" {
  value = azurerm_firewall.firewall
}

output "firewall_private_ip_address" {
  value = azurerm_firewall.firewall.ip_configuration[0].private_ip_address
}