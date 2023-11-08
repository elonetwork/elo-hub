module "vnet_hub" {
  source              = "../../../modules/vnet"
  vnet_name           = var.vnet_name
  address_space       = ["10.100.0.0/16"]
  location            = var.location
  resource_group_name = var.resource_group_name
}


module "firewall" {
  source              = "../subnets/firewall"
  location            = var.location
  resource_group_name = var.resource_group_name
  vnet_name           = module.vnet_hub.vnet_name
  bastion_vm_ip       = module.bastion.vm_private_ip
}

module "bastion" {
  source              = "../subnets/bastion/"
  subnet_name         = var.bastion_subnet_name
  resource_group_name = var.resource_group_name
  location            = var.location
  address_prefixes    = ["10.100.1.0/24"]
  vnet_name           = module.vnet_hub.vnet_name
  ssh_public_key      = var.ssh_public_key
}

module "squid" {
  source              = "../subnets/squid/"
  resource_group_name = var.resource_group_name
  location            = var.location
  address_prefixes    = ["10.100.2.0/24"]
  vnet_name           = module.vnet_hub.vnet_name
  subnet_name         = var.squide_subnet_name
  firewall_private_ip = module.firewall.firewall_private_ip
}



output "firewall_public_ip" {
  value = module.firewall.firewall_public_ip
}

output "firewall_mgm_public_ip" {
  value = module.firewall.firewall_mgm_public_ip
}

output "squid_private_ip" {
  value = module.squid.vm_private_ip
}

