output "subnet-bastion-id" {
  value = module.subnet-bastion.subnet_id
}

output "subnet-firewall-id" {
  value = module.subnet-firewall.subnet_id
}

output "subnet-squid-id" {
  value = module.subnet-squid.subnet_id
}

output "vnet-hub-name" {
  value = azurerm_virtual_network.vnet-hub.name
}


output "subnet-firwall-mgm-id" {
  value = module.firewall-mgmt.subnet_id
}