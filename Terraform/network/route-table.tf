resource "azurerm_route_table" "squid_route" {
  name                = var.squid_route_name
  location            = var.location
  resource_group_name = var.resource_group_name
}

resource "azurerm_route" "internet_route" {
  name                   = var.internet_route_name
  route_table_name       = azurerm_route_table.squid_route.name
  resource_group_name    = var.resource_group_name
  address_prefix         = "0.0.0.0/0"
  next_hop_type          = "VirtualAppliance"
  next_hop_in_ip_address = var.firewall_private_ip_address
}

resource "azurerm_subnet_route_table_association" "squid_subnet_association" {
  route_table_id = azurerm_route_table.squid_route.id
  subnet_id      = var.subnet_ids["squid"]
}