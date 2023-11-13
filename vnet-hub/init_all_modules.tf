provider "azurerm" {
features {}
skip_provider_registration = true
}

module "infrastructure" {
  source = "./modules/infrastructure"
  vnet_hub_name       = var.vnet_hub_name
  address_space       = var.address_space
  location            = var.location
  resource_group_name = var.resource_group_name
}

module "network" {
  source = "./modules/network"
  
}


module "security" {
  source = "./modules/security"
  vnet_hub_name       = var.vnet_hub_name
  address_space       = var.address_space
  location            = var.location
  resource_group_name = var.resource_group_name
}

# # #init the vnet-prd ressources
# module "vnet-prd" {
#   source = "./vnet-prd/"
# }
# # #init the vnet-prd ressources
# module "vnet-mgm" {
#   source = "./vnet-mgm/"
# }
