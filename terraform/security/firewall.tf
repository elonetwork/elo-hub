module "public_ip_firewall" {
  source              = "../modules/public_ip"
  name                = var.public_ip_firewall_name
  resource_group_name = var.resource_group_name
  location            = var.location
}   

module "public_ip_firewall_mgmt" {
  source              = "../modules/public_ip"
  name                = var.public_ip_firewall_mgmt_name
  resource_group_name = var.resource_group_name
  location            = var.location
}   

resource "azurerm_firewall" "elo-network" {
  name                = var.firewal_name
  location            = var.location
  resource_group_name = var.resource_group_name
  sku_name            = "AZFW_VNet"
  sku_tier            = "Basic"

  ip_configuration {
    name                 = "configuration"
    subnet_id            = var.sub_firewall_id
    public_ip_address_id = module.public_ip_firewall.id
  }

  management_ip_configuration {
    name                 = "management"
    subnet_id            = var.sub_firewall_mgm_id
    public_ip_address_id = module.public_ip_firewall_mgmt.id
  }
}