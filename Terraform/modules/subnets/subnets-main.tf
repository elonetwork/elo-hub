variable "resource_group_name" {
  description = "The name of the Azure resource group where the VNet is located."
  type        = string
}

variable "vnet_name" {
  description = "The name of the Azure Virtual Network where subnets will be created."
  type        = string
}

variable "subnets" {
  description = "A map of subnets to create, where keys are subnet names and values are address prefixes."
  type        = map(string)
}

resource "azurerm_subnet" "subnet" {
  for_each             = var.subnets
  name                 = each.key
  resource_group_name  = var.resource_group_name
  virtual_network_name = var.vnet_name
  address_prefixes     = [each.value]
}

output "subnet_ids" {
  description = "The IDs of the created subnets."
  value       = azurerm_subnet.subnet[*].id
}