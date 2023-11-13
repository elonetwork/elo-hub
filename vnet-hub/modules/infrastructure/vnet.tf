
### Create Virtual Network vnet-hub  -------------------------**
resource "azurerm_virtual_network" "vnet-hub" {
  name                = var.vnet_hub_name
  address_space       = var.address_space
  location            = var.location
  resource_group_name = var.resource_group_name
}
#*********************************end