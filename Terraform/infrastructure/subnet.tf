

resource "azurerm_subnet" "sub_firewall" {
  name                 = var.subnet_names["azure_firewall"]
  resource_group_name  = var.resource_group_name
  virtual_network_name = module.hub_vnet.vnet_name
  address_prefixes     = [var.address_prefixes["azure_firewall"]]
}

resource "azurerm_subnet" "sub_bastion" {
  name                 = var.subnet_names["sub_bastion"]
  resource_group_name  = var.resource_group_name
  virtual_network_name = module.hub_vnet.vnet_name
  address_prefixes     = [var.address_prefixes["sub_bastion"]]
}

resource "azurerm_subnet" "sub_squid" {
  name                 = var.subnet_names["sub_squid"]
  resource_group_name  = var.resource_group_name
  virtual_network_name = module.hub_vnet.vnet_name
  address_prefixes     = [var.address_prefixes["sub_squid"]]
}

resource "azurerm_subnet" "firewall_mgmt" {
  name                 = var.subnet_names["firewall_management"]
  resource_group_name  = var.resource_group_name
  virtual_network_name = module.hub_vnet.vnet_name
  address_prefixes     = [var.address_prefixes["firewall_management"]]
}
