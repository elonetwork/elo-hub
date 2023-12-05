
output "squid_vm_private_ip" {
  description = "private ip address of squid vm"
  value       = azurerm_network_interface.squid_nic.private_ip_address
}


output "bastion_subnet_id" {
  value = azurerm_subnet.sub_bastion.id
}


output "squid_subnet_id" {
  value = azurerm_subnet.sub_squid.id
}

output "firewall_subnet_id" {
  value = azurerm_subnet.sub_firewall.id
}

output "firewall-mgmt_id" {
  value = azurerm_subnet.firewall_mgmt.id
}

output "hub_vnet_name" {
  value = module.hub_vnet.vnet_name
}

output "hub_vnet_id" {
  value = module.hub_vnet.vnet_id
}

output "hub_vnet_address" {
  value = module.hub_vnet.vnet_address
}

output "bastion_private_ip" {
  value = azurerm_network_interface.bastion_nic.ip_configuration[0].private_ip_address
}
