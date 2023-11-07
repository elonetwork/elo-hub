module "vnet-hub" {
  source             = "../../Resources/Vnet"
  name               = "vnet-hub"
  location           = var.location
  resourcegroup-name = var.resourcegroup-name
  address_space      = ["10.100.0.0/16"]
}

output "vnet-hub-object" {
  value = module.vnet-hub
}