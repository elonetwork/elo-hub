output "vnet_id" {
  description = "ID of the created VNet"
  value       = azurerm_virtual_network.vnet_hub.id
}

output "firewall_public_ip_address" {
  description = "public ip :firewall"
  value = azurerm_public_ip.publicIP.ip_address
}

output "firewall_private_ip_address" {
  description = "private ip :firewall"
  value = azurerm_firewall.Firewall.ip_configuration[0].private_ip_address
}

output "squid_vm_private_ip" {
  description = "private ip address of squid vm"
  value = azurerm_network_interface.squid_nic.private_ip_address
}