resource "azurerm_network_security_group" "nsg_sub_bastion" {
  name                = var.nsg_names["sub_bastion"]
  location            = var.location
  resource_group_name = var.resource_group_name
}

resource "azurerm_network_security_group" "nsg_sub_squid" {
  name                = var.nsg_names["sub_squid"]
  location            = var.location
  resource_group_name = var.resource_group_name
}


# Associate NSG with subnets
resource "azurerm_subnet_network_security_group_association" "nsg_association_sub_bastion" {
  subnet_id                 = var.subnet_ids["bastion"]
  network_security_group_id = azurerm_network_security_group.nsg_sub_bastion.id
}

resource "azurerm_subnet_network_security_group_association" "nsg_association_sub_squid" {
  subnet_id                 = var.subnet_ids["squid"]
  network_security_group_id = azurerm_network_security_group.nsg_sub_squid.id
}