resource "azurerm_route_table" "squid_route" {
  name                = var.route-table-name
  location            = var.location
  resource_group_name = var.resource_group_name
}

resource "azurerm_route" "http_route" {
  name                   = var.route-squid-name
  route_table_name       = azurerm_route_table.squid_route.name
  resource_group_name    = var.resource_group_name
  address_prefix         = var.route-address-prefix
  next_hop_type          = var.route-squid-next-hop-type
  next_hop_in_ip_address =var.route-squid-next_hop_in_ip_address
}
resource "azurerm_subnet_route_table_association" "squid_subnet_association" {
  route_table_id = azurerm_route_table.squid_route.id
  subnet_id      = var.subnet-squid-id
}