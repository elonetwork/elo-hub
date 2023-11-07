resource "azurerm_network_security_group" "nsg_subnet" {
  name = var.name
  location = var.location
  resource_group_name = var.resource_group_name
}