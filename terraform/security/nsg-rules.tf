
# Allow inboud  ssh connection to the bastion private ip
resource "azurerm_network_security_rule" "nsr_in_ssh_vm_bastion" {
  name                        = "nsr_ssh_vm_bastion"
  priority                    = 110
  direction                   = "Inbound"
  access                      = "Allow"
  protocol                    = "Tcp"
  source_port_range           = "*"
  destination_port_ranges     = ["22"]
  source_address_prefix       = "*"
  destination_address_prefix  = var.bastion_private_ip
  resource_group_name         = var.resource_group_name
  network_security_group_name = module.nsg-sub-bastion.nsg_name
}

# allow outbound ssh from bastion vm to other vms
resource "azurerm_network_security_rule" "nsr_out_ssh_vm_bastion" {
  name                        = "nsr_out_ssh_vm_bastion"
  priority                    = 110
  direction                   = "Outbound"
  access                      = "Allow"
  protocol                    = "Tcp"
  source_port_range           = "*"
  destination_port_ranges     = ["22"]
  source_address_prefix       = var.bastion_private_ip
  destination_address_prefix  = "*"
  resource_group_name         = var.resource_group_name
  network_security_group_name = module.nsg-sub-bastion.nsg_name
}


# Allow inboud  ssh connection to the squid private ip
resource "azurerm_network_security_rule" "nsr_in_ssh_vm_squid" {
  name                        = "nsr_in_ssh_vm_squid"
  priority                    = 110
  direction                   = "Inbound"
  access                      = "Allow"
  protocol                    = "Tcp"
  source_port_range           = "*"
  destination_port_ranges     = ["22"]
  source_address_prefix       = "*"
  destination_address_prefix  = var.squid_private_ip
  resource_group_name         = var.resource_group_name
  network_security_group_name = module.nsg-sub-squid.nsg_name
}

# Allow outbound hhtp and https connection from vm squid
resource "azurerm_network_security_rule" "nsr_out_web_vm_squid" {
  name                        = "nsr_out_web_vm_squid"
  priority                    = 110
  direction                   = "Outbound"
  access                      = "Allow"
  protocol                    = "*"
  source_port_range           = "*"
  destination_port_ranges     = ["80", "443"]
  source_address_prefix       = var.squid_private_ip
  destination_address_prefix  = "*"
  resource_group_name         = var.resource_group_name
  network_security_group_name = module.nsg-sub-squid.nsg_name
}


# Allow outbound hhtp and https connection from vm bastion
resource "azurerm_network_security_rule" "nsr_out_web_vm_bastion" {
  name                        = "nsr_out_web_vm_squid"
  priority                    = 111
  direction                   = "Outbound"
  access                      = "Allow"
  protocol                    = "*"
  source_port_range           = "*"
  destination_port_ranges     = ["80", "443", "53"]
  source_address_prefix       = var.bastion_private_ip
  destination_address_prefix  = "*"
  resource_group_name         = var.resource_group_name
  network_security_group_name = module.nsg-sub-bastion.nsg_name
}

