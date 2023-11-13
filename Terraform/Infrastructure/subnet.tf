module "subnet-bastion" {
  source               = "../Modules/module-subnet"
  resource_group_name  = var.resource_group_name
  name                 = var.name-subnet-bastion
  virtual_network_name = azurerm_virtual_network.vnet-hub.name
  address_prefixes     = var.address-prefixes-subnet-bastion
}

module "subnet-firewall" {
  source               = "../Modules/module-subnet"
  resource_group_name  = var.resource_group_name
  name                 = var.name-subnet-firewall
  virtual_network_name = azurerm_virtual_network.vnet-hub.name
  address_prefixes     = var.address-prefixes-subnet-firewall
}

module "subnet-squid" {
  source               = "../Modules/module-subnet"
  resource_group_name  = var.resource_group_name
  name                 = var.name-subnet-squid
  virtual_network_name = azurerm_virtual_network.vnet-hub.name
  address_prefixes     = var.address-prefixes-subnet-squid
}

module "firewall-mgmt" {
  source               = "../Modules/module-subnet"
  name                 = var.name-subnet-firewall-mgm
  resource_group_name  = var.resource_group_name
  virtual_network_name =azurerm_virtual_network.vnet-hub.name
  address_prefixes     = var.address-prefixes-subnet-firewall-mgm
}

