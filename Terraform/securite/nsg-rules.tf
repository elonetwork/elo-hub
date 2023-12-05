
resource "azurerm_network_security_rule" "nsg_sub_bastion_allow_inbound_ssh" {
  name                        = "Allow-SSH"
  priority                    = var.nsg_rule_priorities["allow_ssh"]
  direction                   = "Inbound"
  access                      = "Allow"
  protocol                    = "Tcp"
  source_port_range           = "*"
  destination_port_range      = "22"
  source_address_prefix       = "*"
  destination_address_prefix  = "*"
  resource_group_name         = var.resource_group_name
  network_security_group_name = azurerm_network_security_group.nsg_sub_bastion.name
}

resource "azurerm_network_security_rule" "nsg_sub_squid_allow_inbound_ssh" {
  name                        = "Allow-SSH"
  priority                    = var.nsg_rule_priorities["allow_ssh"]
  direction                   = "Inbound"
  access                      = "Allow"
  protocol                    = "Tcp"
  source_port_range           = "*"
  destination_port_range      = "22"
  source_address_prefix       = "*"
  destination_address_prefix  = "*"
  resource_group_name         = var.resource_group_name
  network_security_group_name = azurerm_network_security_group.nsg_sub_squid.name
}

resource "azurerm_network_security_rule" "nsg_sub_squid_allow_outbound_http" {
  name                        = "Allow-HTTP"
  priority                    = var.nsg_rule_priorities["allow_http"]
  direction                   = "Outbound"
  access                      = "Allow"
  protocol                    = "Tcp"
  source_port_range           = "*"
  destination_port_range      = "80"
  source_address_prefix       = "*"
  destination_address_prefix  = "*"
  resource_group_name         = var.resource_group_name
  network_security_group_name = azurerm_network_security_group.nsg_sub_squid.name
}

resource "azurerm_network_security_rule" "nsg_sub_squid_allow_outbound_https" {
  name                        = "Allow-Outbound-HTTPS"
  priority                    = var.nsg_rule_priorities["allow_outbound_tls"]
  direction                   = "Outbound"
  access                      = "Allow"
  protocol                    = "Tcp"
  source_port_range           = "*"
  destination_port_range      = "443"
  source_address_prefix       = "*"
  destination_address_prefix  = "*"
  resource_group_name         = var.resource_group_name
  network_security_group_name = azurerm_network_security_group.nsg_sub_squid.name
}

resource "azurerm_network_security_rule" "nsg_sub_squid_deny_all_outbound" {
  name                        = "Deny-All-Outbound-Traffic"
  priority                    = var.nsg_rule_priorities["deny_outbound"]
  direction                   = "Outbound"
  access                      = "Deny"
  protocol                    = "*"
  source_port_range           = "*"
  destination_port_range      = "*"
  source_address_prefix       = "*"
  destination_address_prefix  = "*"
  resource_group_name         = var.resource_group_name
  network_security_group_name = azurerm_network_security_group.nsg_sub_squid.name
}

resource "azurerm_network_security_rule" "nsg_sub_squid_deny_all_inbound" {
  name                        = "Deny-All-Inbound-Traffic"
  priority                    = var.nsg_rule_priorities["deny_inbound"]
  direction                   = "Inbound"
  access                      = "Deny"
  protocol                    = "*"
  source_port_range           = "*"
  destination_port_range      = "*"
  source_address_prefix       = "*"
  destination_address_prefix  = "*"
  resource_group_name         = var.resource_group_name
  network_security_group_name = azurerm_network_security_group.nsg_sub_squid.name
}
