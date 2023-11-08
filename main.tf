#init the vnet-hub resources
module "vnet-hub" {
  source = "./modules/vnet-hub"
}

#init the vnet-prd ressources
module "vnet-prd" {
  source = "./modules/vnet-prd"
}

#init the vnet-mgm ressources
###

