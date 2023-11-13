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
  protocol                    = var.protocole-tcp
  source_port_range           = var.value-etoile
  destination_port_range      = var.port22
  source_address_prefix       = var.value-etoile
  destination_address_prefix  = var.value-etoile
  resource_group_name         = var.resource_group_name
  network_security_group_name = module.nsg_sequid.nsg-name
}

module "nsg-http-allow-outbound-squid" {
  source                      = "../Modules/module-nsr"
  name                        = var.name-nsg-http-allow-outbound-squid
  priority                    =  var.priority-100
  direction                   = var.direction-outbound
  access                      = var.access-allow
  protocol                    = var.protocole-tcp
  source_port_range           = var.value-etoile
  destination_port_range      = var.protocole-http
  source_address_prefix       = var.value-etoile
  destination_address_prefix  = var.value-etoile
  resource_group_name         = var.resource_group_name
  network_security_group_name = module.nsg_sequid.nsg-name
}

module "nsg-https-allow-outbound-squid" {
  source                      = "../Modules/module-nsr"
  name                        = var.name-nsg-https-allow-outbound-squid
  priority                    = var.priority-110
  direction                   = var.direction-outbound
  access                      = var.access-allow
  protocol                    = var.protocole-tcp
  source_port_range           = var.value-etoile
  destination_port_range      = var.protocole-https
  source_address_prefix       = var.value-etoile
  destination_address_prefix  = var.value-etoile
  resource_group_name         = var.resource_group_name
  network_security_group_name = module.nsg_sequid.nsg-name
}

module "nsg-deny-all-outbound-squid" {
  source                      = "../Modules/module-nsr"
  name                        = var.name-nsg-deny-all-outbound-squid
  priority                    = var.priority-200
  direction                   = var.direction-outbound
  access                      = var.access-deny
  protocol                    = var.value-etoile
  source_port_range           = var.value-etoile
  destination_port_range      = var.value-etoile
  source_address_prefix       = var.value-etoile
  destination_address_prefix  = var.value-etoile
  resource_group_name         = var.resource_group_name
  network_security_group_name = module.nsg_sequid.nsg-name
}
