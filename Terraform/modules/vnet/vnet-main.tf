variable "resource_group_name" {
  description = "The name of the Azure resource group where the VNet will be created."
  type        = string
}

variable "vnet_name" {
  description = "The name of the Azure VNet."
  type        = string
}

variable "address_space" {
  description = "The address space for the VNet."
  type        = list(string)
}

variable "location" {
  description = "The location for the VNet."
  type        = string
}

# Define the Azure VNet resource
resource "azurerm_virtual_network" "vnet" {
  name                = var.vnet_name
  resource_group_name = var.resource_group_name
  address_space       = var.address_space
  location            = var.location
}

# Output the VNet ID
output "vnet_id" {
  description = "The ID of the Azure VNet."
  value       = azurerm_virtual_network.vnet.id
}

# Output the VNet ID
output "vnet_name" {
  description = "The Name of the Azure VNet."
  value       = azurerm_virtual_network.vnet.name
}

output "vnet_address" {
  description = "The address of the Azure VNet."
  value       = azurerm_virtual_network.vnet.address_space[0]
}