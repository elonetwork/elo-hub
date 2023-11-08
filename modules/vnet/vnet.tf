resource "azurerm_virtual_network" "elo-network" {
  name                = var.vnet_name
  address_space       = var.address_space
  location            = var.location
  resource_group_name = var.resource_group_name
}

variable "vnet_name" {
  description = "Name of the Virtual Network"
}

variable "address_space" {
  description = "Address space of the Virtual Network"
}

variable "location" {
  description = "Location for the Virtual Network"
}

variable "resource_group_name" {
  description = "Name of the Resource Group"
}

output "vnet_id" {
  value = azurerm_virtual_network.elo-network.id
  description = "ID of the virtual network from the module"
}

output "vnet_name" {
  value = azurerm_virtual_network.elo-network.name
  description = "Name of the virtual network from the module"
}