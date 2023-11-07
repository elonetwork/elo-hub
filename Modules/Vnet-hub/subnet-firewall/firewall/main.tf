resource "azurerm_firewall" "firewall" {
  name                = var.name
  location            = var.location
  resource_group_name = var.resource_group_name
  sku_name            = var.sku_name
  sku_tier            = var.sku_tier

  ip_configuration {
    name                 = var.name_ip_configuration
    subnet_id            = var.subnet_id
    public_ip_address_id = var.public_ip_address_id
  }

  management_ip_configuration {
    name                 = var.name_ip_management
    subnet_id            = var.subnet_id_management
    public_ip_address_id = var.public_ip_address_id_management
  }
}