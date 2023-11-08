resource "azurerm_network_security_group" "elo-network" {
  name = var.nsg_name
  location            = var.nsg_location
  resource_group_name = var.resource_group_name
}

resource "azurerm_subnet_network_security_group_association" "example" {
  subnet_id                 = var.subnet_id
  network_security_group_id = azurerm_network_security_group.elo-network.id
}

variable "subnet_id" {
  description = "ID of the subnet"
}

variable "nsg_name" {
  description = "Name of the Network security group"
}

variable "nsg_location" {
  description = "Location for Network security group"
}

variable "resource_group_name" {
  description = "Name of the Resource Group"
}

output "nsg_id" {
  value = azurerm_network_security_group.elo-network.id
  description = "ID of nsg from the module"
}

output "nsg_name" {
  value = azurerm_network_security_group.elo-network.name
  description = "Name of nsg from the module"
}