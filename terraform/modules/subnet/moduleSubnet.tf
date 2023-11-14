# resource "azurerm_subnet" "elo-network" {
#   count                = length(var.subnets)
#   name                 = var.subnets[count.index].name
#   resource_group_name  = var.resource_group_name
#   virtual_network_name = var.network_name
#   address_prefixes     = var.subnets[count.index].address_prefixes
# }

resource "azurerm_subnet" "elo-network" {
  name                 = var.name
  resource_group_name  = var.resource_group_name
  virtual_network_name = var.network_name
  address_prefixes     = var.address_prefixes
}
