output "squid_private_ip" {
  value = azurerm_network_interface.interface-squid.ip_configuration[0].private_ip_address
}

