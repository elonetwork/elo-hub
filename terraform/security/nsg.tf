module "nsg-sub-bastion" {
  source              = "../modules/nsg/"
  subnet_id           = var.sub_bastion_id
  name                = "nsg-sub-bastion"
  nsg_location        = var.location
  resource_group_name = var.resource_group_name
}

module "nsg-sub-squid" {
  source              = "../modules/nsg/"
  subnet_id           = var.sub_squid_id
  name                = "nsg-sub-squid"
  nsg_location        = var.location
  resource_group_name = var.resource_group_name
}
