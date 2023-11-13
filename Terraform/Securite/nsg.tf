module "nsg_bastion" {
  source              = "../Modules/module-nsg"
  name                = var.name-bastion
  location            = var.location
  resource_group_name = var.resource_group_name
}

module "nsg_sequid" {
  source              = "../Modules/module-nsg"
  name                = var.name-sequid
  location            = var.location
  resource_group_name = var.resource_group_name
}

resource "azurerm_subnet_network_security_group_association" "assoss_subnet_bastion" {
  subnet_id                 = var.subnet-bastion
  network_security_group_id = module.nsg_bastion.nsg-id
}

resource "azurerm_subnet_network_security_group_association" "assoss_subnet_squid" {
  subnet_id                 = var.subnet-sequid
  network_security_group_id = module.nsg_sequid.nsg-id
}