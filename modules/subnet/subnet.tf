resource "azurerm_subnet" "elo-network" {
  name = var.subnet_name
  resource_group_name = var.resource_group_name
  virtual_network_name = var.network_name
  address_prefixes = var.address_prefixes
}

variable "subnet_name" {
  description = "Name of the subnet"
}

variable "network_name" {
  description = "name of the Virtual Network"
}

variable "address_prefixes" {
  description = "address_prefixes for the Virtual Network"
}

variable "resource_group_name" {
  description = "Name of the Resource Group"
}

output "subnet_id" {
  value = azurerm_subnet.elo-network.id
  description = "ID of the subnet from the module"
}

output "subnet_name" {
  value = azurerm_subnet.elo-network.name
  description = "Name of the subnet from the module"
}