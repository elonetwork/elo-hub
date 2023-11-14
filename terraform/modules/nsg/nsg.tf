resource "azurerm_network_security_group" "elo-network" {
  name = var.name
  location            = var.nsg_location
  resource_group_name = var.resource_group_name
}

resource "azurerm_subnet_network_security_group_association" "example" {
  subnet_id                 = var.subnet_id
  network_security_group_id = azurerm_network_security_group.elo-network.id
}

resource "azurerm_network_security_rule" "deny_all_Inbound" {
  name                        = "deny-all_Inbound-${var.name}"
  priority                    = 1000
  direction                   = "Inbound"
  access                      = "Deny"
  protocol                    = "*"
  source_port_range           = "*"
  destination_port_range      = "*"
  source_address_prefix       = "*"
  destination_address_prefix  = "*"
  resource_group_name         = var.resource_group_name
  network_security_group_name  = azurerm_network_security_group.elo-network.name
}

resource "azurerm_network_security_rule" "deny_all_Outbound" {
  name                        = "deny-all-Outbound-${var.name}"
  priority                    = 1000
  direction                   = "Outbound"
  access                      = "Deny"
  protocol                    = "*"
  source_port_range           = "*"
  destination_port_range      = "*"
  source_address_prefix       = "*"
  destination_address_prefix  = "*"
  resource_group_name         = var.resource_group_name
  network_security_group_name  = azurerm_network_security_group.elo-network.name
}



