


resource "azurerm_subnet" "aks_subnet" {
  name                                           = format("%s_aks_subnet", var.env_name)
  resource_group_name                            = var.resource_group_name
  virtual_network_name                           = var.virtual_network_name
  address_prefixes                               = var.subnet_address_prefixes
  enforce_private_link_endpoint_network_policies = true

}

resource "azurerm_network_security_group" "aks_nsg" {
  name                = format("%s_aks_nsg", var.env_name)
  location            = var.location
  resource_group_name = var.resource_group_name

  security_rule {
    name                       = "Allow-Inbound-SSH"
    protocol                   = "Tcp"
    direction                  = "Inbound"
    priority                   = 101
    source_port_range          = "*"
    destination_port_range     = "22"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
    access                     = "Allow"
  }

  security_rule {
    name                       = "Allow-Inbound-HTTPS"
    protocol                   = "Tcp"
    direction                  = "Inbound"
    source_port_range          = "*"
    priority                   = 102
    destination_port_range     = "443"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
    access                     = "Allow"
  }
  security_rule {
    name                       = "Allow-Inbound-HTTP"
    protocol                   = "Tcp"
    direction                  = "Inbound"
    source_port_range          = "*"
    priority                   = 103
    destination_port_range     = "80"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
    access                     = "Allow"
  }

  security_rule {
    name                       = "Allow-Outbound-HTTPS"
    protocol                   = "Tcp"
    direction                  = "Outbound"
    source_port_range          = "*"
    priority                   = 102
    destination_port_range     = "443"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
    access                     = "Allow"
  }
  security_rule {
    name                       = "Allow-Outbound-HTTP"
    protocol                   = "Tcp"
    direction                  = "Outbound"
    source_port_range          = "*"
    priority                   = 103
    destination_port_range     = "80"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
    access                     = "Allow"
  }
}

resource "azurerm_subnet_network_security_group_association" "aks_nsg_association" {
  subnet_id                 = azurerm_subnet.aks_subnet.id
  network_security_group_id = azurerm_network_security_group.aks_nsg.id
}

resource "azurerm_private_dns_zone" "aks_dns_zone" {
  name                = format("%s.private.%s.azmk8s.io", var.env_name, var.location)
  resource_group_name = var.resource_group_name
}

resource "azurerm_kubernetes_cluster" "aks_cluster" {
  name                = format("%s_aks_cluster", var.env_name)
  resource_group_name = var.resource_group_name
  location            = var.location

  network_profile {
    network_plugin = "azure"
  }

  private_cluster_enabled = true
  private_dns_zone_id     = azurerm_private_dns_zone.aks_dns_zone.id
  dns_prefix              = format("%s", var.env_name)

  azure_active_directory_role_based_access_control {
    managed            = true
    azure_rbac_enabled = true
  }
  private_cluster_public_fqdn_enabled = false


  service_principal {
    client_id     = var.aks_service_principal.client_id
    client_secret = var.aks_service_principal.client_secret
  }
  default_node_pool {
    name           = "nodepool"
    vm_size        = "Standard_D2s_v3"
    node_count     = 3
    vnet_subnet_id = azurerm_subnet.aks_subnet.id

  }
  tags = {
    Environement = var.environement
  }
}


resource "azurerm_private_endpoint" "aks_endpoint" {
  name                = format("%s_private-endpoint", var.env_name)
  location            = var.location
  resource_group_name = var.resource_group_name

  subnet_id = azurerm_subnet.aks_subnet.id

  private_service_connection {
    name                           = format("%s_private-connection", var.env_name)
    private_connection_resource_id = azurerm_kubernetes_cluster.aks_cluster.id
    is_manual_connection           = false
    subresource_names              = ["management"]
  }

  tags = {
    environment = var.environement
  }
}


resource "azurerm_private_dns_zone_virtual_network_link" "aks_dns_zone_link" {
  name                  = format("%s_elonet_dns_zone_link", var.env_name)
  resource_group_name   = var.resource_group_name
  virtual_network_id    = var.virtual_network_id
  private_dns_zone_name = azurerm_private_dns_zone.aks_dns_zone.name
  registration_enabled  = true

}


#link dns zone to hub vnet
resource "azurerm_private_dns_zone_virtual_network_link" "aks_dns_zone_link2" {
  name                  = format("%s_elonet_dns_zone_link2", var.env_name)
  resource_group_name   = var.resource_group_name
  virtual_network_id    = var.hub_vnet_id
  private_dns_zone_name = azurerm_private_dns_zone.aks_dns_zone.name
  registration_enabled  = true

}

