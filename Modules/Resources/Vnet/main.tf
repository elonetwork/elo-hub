resource "azurerm_virtual_network" "vnet-hub" {
  name                = var.name
  location            = var.location
  resource_group_name = var.resourcegroup-name
  address_space       = var.address_space
}