module "sub-firewall" {
  depends_on          = [module.vnet_hub]
  source              = "../modules/subnet/"
  name                = var.sub_firewall_name
  resource_group_name = var.resource_group_name
  network_name        = var.vnet_hub_name
  address_prefixes    = [var.sub_firewall_address_prefixes]
}

module "sub-firewall-mgm" {
  depends_on          = [module.vnet_hub]
  source              = "../modules/subnet/"
  name                = var.sub_firewall_mgm_name
  resource_group_name = var.resource_group_name
  network_name        = var.vnet_hub_name
  address_prefixes    = [var.sub_firewall_mgm_address_prefixes]
}

module "sub-squide" {
  depends_on          = [module.vnet_hub]
  source              = "../modules/subnet/"
  name                = var.sub_squid_address_name
  resource_group_name = var.resource_group_name
  network_name        = var.vnet_hub_name
  address_prefixes    = [var.sub_squid_address_prefixes]
}

module "sub-bastion" {
  depends_on          = [module.vnet_hub]
  source              = "../modules/subnet/"
  name                = var.sub_bastion_address_name
  resource_group_name = var.resource_group_name
  network_name        = var.vnet_hub_name
  address_prefixes    = [var.sub_bastion_address_prefixes]
}
