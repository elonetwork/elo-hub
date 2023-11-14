# direct traffic from squid vm to go through the firewall
resource "azurerm_route_table" "squid_route_table" {
  name                = var.squid-vm-route-table_name
  location            = var.location
  resource_group_name = var.resource_group_name
}

resource "azurerm_route" "squid_route" {
  name                   = var.squid_route_name
  route_table_name       = azurerm_route_table.squid_route_table.name
  resource_group_name    = azurerm_route_table.squid_route_table.resource_group_name
  address_prefix         = var.squid_route_address_prefix
  next_hop_type          = var.squid_route_next_hop_type
  next_hop_in_ip_address = var.firewall_private_ip
}

resource "azurerm_subnet_route_table_association" "squid_association" {
  subnet_id      = var.sub_squid_id
  route_table_id = azurerm_route_table.squid_route_table.id
}