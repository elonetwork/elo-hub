module "hub_vnet" {
  source = "../modules/vnet"
  # Provide input variable values
  resource_group_name = var.resource_group_name
  location            = var.location
  vnet_name           = var.hub_vnet_name
  address_space       = var.address_space
}


