module "app_interface_bastion" {
  source = "../Modules/module-interface"
  name-interface = var.name-interface
  resource_group_name=var.resource_group_name
  subnet_id = var.subnet_id
  location = var.location
}