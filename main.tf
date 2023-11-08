# main.tf


resource "azurerm_resource_group" "elo-network" {
  name     = var.resource_group_name
  location = var.location
}

#  
module "vnet_hub" {
  depends_on          = [azurerm_resource_group.elo-network]
  source              = "./vnets/vnet_hub/main/"
  vnet_name           = var.vnet_name
  resource_group_name = var.resource_group_name
  location            = var.location
  ssh_public_key = var.ssh_public_key
}


output "firewall_public_ip" {
  value = module.vnet_hub.firewall_public_ip
}

output "firewall_mgm_public_ip" {
  value = module.vnet_hub.firewall_mgm_public_ip
}

output "squid_private_ip" {
  value = module.vnet_hub.squid_private_ip
}
