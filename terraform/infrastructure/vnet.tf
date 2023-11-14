module "vnet_hub" {
  source              = "../modules/vnet/"
  name                = var.vnet_hub_name
  address_space       = [var.vnet_hub_address_space]
  location            = var.location
  resource_group_name = var.resource_group_name
}
