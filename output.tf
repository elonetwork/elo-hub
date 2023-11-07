output "bastion_private" {
  value = azurerm_network_interface.app_interface.ip_configuration[0].private_ip_address
}

output "squid_private" {
  value = azurerm_network_interface.app_interface_squid.ip_configuration[0].private_ip_address
}

output "firewall_public" {
  value = module.public_ip_firwall.publicip_adress
}
