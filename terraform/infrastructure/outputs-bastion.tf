output "bastion_private_ip" {
  value = azurerm_network_interface.interface-bastion.ip_configuration[0].private_ip_address
}
