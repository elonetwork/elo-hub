module "deny-all-inbound-rule-bastion" {
  source                      = "../Modules/module-nsr"
  name                        = var.name-deny-all-inbound-rule-bastion
  priority                    = var.priority-1000
  direction                   = var.direction-inbound
  access                      = var.access-deny
  source_port_range           = var.value-etoile
  destination_port_range      = var.value-etoile
  source_address_prefix       = var.value-etoile
  destination_address_prefix  = var.value-etoile
  resource_group_name         = var.resource_group_name
  network_security_group_name = module.nsg_bastion.nsg-name
}

module "allow-tcp-outbound-rule-bastion" {
  source                      = "../Modules/module-nsr"
  name                        = var.name-allow-tcp-outbound-rule-bastion
  priority                    = var.priority-100
  direction                   = var.direction-outbound
  access                      = var.access-allow
  protocol                    = var.protocole-tcp
  source_port_range           = var.value-etoile
  destination_port_range      = var.port22
  source_address_prefix       = var.value-etoile
  destination_address_prefix  = var.value-etoile
  resource_group_name         = var.resource_group_name
  network_security_group_name = module.nsg_bastion.nsg-name
}

module "allow-tcp-inbound-rule-bastion" {
  source                      = "../Modules/module-nsr"
  name                        = var.name-allow-tcp-inbound-rule-bastion
  priority                    = var.priority-100
  direction                   = var.direction-inbound
  access                      = var.access-allow
  protocol                    = var.protocole-tcp
  source_port_range           = var.value-etoile
  destination_port_range      = var.port22
  source_address_prefix       = var.value-etoile
  destination_address_prefix  = var.value-etoile
  resource_group_name         = var.resource_group_name
  network_security_group_name = module.nsg_bastion.nsg-name
}

module "deny-all-inbound-rule-squid" {
  source                      = "../Modules/module-nsr"
  name                        = var.name-deny-all-inbound-rule-squid
  priority                    = var.priority-1000
  direction                   = var.direction-inbound
  access                      = var.access-deny
  source_port_range           = var.value-etoile
  destination_port_range      = var.value-etoile
  source_address_prefix       = var.value-etoile
  destination_address_prefix  = var.value-etoile
  resource_group_name         = var.resource_group_name
  network_security_group_name = module.nsg_sequid.nsg-name
}

module "allow-tcp-inbound-rule-squid" {
  source                      = "../Modules/module-nsr"
  name                        = var.name-allow-tcp-inbound-rule-squid
  priority                    = var.priority-100
  direction                   = var.direction-inbound
  access                      = var.access-allow
  protocol                    =var.protocole-tcp
  source_port_range           = var.value-etoile
  destination_port_range      = var.port22
  source_address_prefix       = var.value-etoile
  destination_address_prefix  = var.value-etoile
  resource_group_name         = var.resource_group_name
  network_security_group_name = module.nsg_sequid.nsg-name
}


