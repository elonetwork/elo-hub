resource "azurerm_public_ip" "elo-network" {
  name                = var.name
  resource_group_name = var.resource_group_name
  location            = var.location
  sku                 = "Standard"
  allocation_method   = "Static"
}

variable "name" {
  description = "The name of the public IP address"
}

variable "resource_group_name" {
  description = "The name of the Azure resource group where the public IP will be created"
}

variable "location" {
  description = "The Azure region where the public IP will be created"
}


output "id" {
  value = azurerm_public_ip.elo-network.id
}


output "ip" {
  value = azurerm_public_ip.elo-network.ip_address
}
