
output "firewall_public_ip_address" {
  description = "public ip address of the firewall"
  value       = azurerm_public_ip.firewall_public_ip.ip_address
}

output "firewall_private_ip_address" {
  description = "private ip address of the firewall"
  value       = azurerm_firewall.hub_firewall.ip_configuration[0].private_ip_address
}
