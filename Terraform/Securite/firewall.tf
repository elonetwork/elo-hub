module "public_ip_firwall" {
  source              = "../Modules/module-public-ip"
  name                = "public_ip_firwall"
  location            = var.location
  resource_group_name = var.resource_group_name
  allocation_method   = "Static"
  sku                 = "Standard"
}

module "public-ip-firewall-mgmt" {
  source              = "../Modules/module-public-ip"
  name                = "fw-mgmt"
  location            = var.location
  resource_group_name = var.resource_group_name
  allocation_method   = "Static"
  sku                 = "Standard"
}

resource "azurerm_firewall" "firewall" {
  name                = var.name-firewall
  location            = var.location
  resource_group_name = var.resource_group_name
  sku_name            = var.sku_name
  sku_tier            = var.sku_tier

  ip_configuration {
    name                 = var.name_ip_configuration
    subnet_id            = var.subnet_id
    public_ip_address_id = module.public_ip_firwall.publicip_object.id
  }

  management_ip_configuration {
    name                 = var.name_ip_management
    subnet_id            = var.subnet_id_management
    public_ip_address_id = module.public-ip-firewall-mgmt.publicip_object.id
  }
}