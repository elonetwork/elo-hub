resource "azurerm_public_ip" "firewall_public_ip" {
  name                = var.firewall_public_ip_name
  location            = var.location
  resource_group_name = var.resource_group_name
  allocation_method   = var.public_ip_allocation_method
  sku                 = var.public_ip_sku
}

resource "azurerm_public_ip" "firewall_mgmt" {
  name                = var.firewall_mgmt_public_ip_name
  location            = var.location
  resource_group_name = var.resource_group_name
  allocation_method   = var.public_ip_allocation_method
  sku                 = var.public_ip_sku
}

resource "azurerm_firewall" "hub_firewall" {
  name                = var.firewall_name
  location            = var.location
  resource_group_name = var.resource_group_name
  sku_name            = var.firewall_sku_name
  sku_tier            = var.firewall_sku_tier

  ip_configuration {
    name                 = "configuration"
    subnet_id            = var.sub_firewall_id
    public_ip_address_id = azurerm_public_ip.firewall_public_ip.id
  }
  management_ip_configuration {
    name                 = "management"
    subnet_id            = var.firewall-mgmt_id
    public_ip_address_id = azurerm_public_ip.firewall_mgmt.id
  }
  depends_on = [
    azurerm_public_ip.firewall_public_ip
  ]
}

