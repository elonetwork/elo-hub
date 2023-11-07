variable "resource_group_name" {
  type = string
  default = "1-7859974b-playground-sandbox"
}
resource "azurerm_virtual_network" "vnet_hub" {
  name                = "vnet-hub"
  address_space       = [var.vnet_address_space]
  location            = azurerm_resource_group.my_rg.location
  resource_group_name = var.resource_group_name
}

resource "azurerm_subnet" "azure_firewall_subnet" {
  name                 = "AzureFirewallSubnet"
  resource_group_name  = azurerm_resource_group.my_rg.name
  virtual_network_name = azurerm_virtual_network.vnet_hub.name
  address_prefixes     = ["10.100.1.0/24"]
}


resource "azurerm_subnet" "sub_bastion" {
  name                 = "sub-bastion"
  resource_group_name  = azurerm_resource_group.my_rg.name
  virtual_network_name = azurerm_virtual_network.vnet_hub.name
  address_prefixes     = ["10.100.2.0/24"]
}

resource "azurerm_subnet" "sub_squid" {
  name                 = "sub-squid"
  resource_group_name  = azurerm_resource_group.my_rg.name
  virtual_network_name = azurerm_virtual_network.vnet_hub.name
  address_prefixes     = ["10.100.3.0/24"]  
}

resource "azurerm_network_security_group" "nsg_sub_squid" {
  name                = "nsg-sub-squid"
  location            = azurerm_resource_group.my_rg.location
  resource_group_name = azurerm_resource_group.my_rg.name
}

resource "azurerm_network_security_group" "nsg_sub_bastion" {
  name                = "nsg-sub-bastion"
  location            = azurerm_resource_group.my_rg.location
  resource_group_name = azurerm_resource_group.my_rg.name
}

# Associate NSG with subnets

resource "azurerm_subnet_network_security_group_association" "nsg_association_sub_bastion" {
  subnet_id                 = azurerm_subnet.sub_bastion.id
  network_security_group_id = azurerm_network_security_group.nsg_sub_bastion.id
}

resource "azurerm_subnet_network_security_group_association" "nsg_association_sub_squid" {
  subnet_id                 = azurerm_subnet.sub_squid.id
  network_security_group_id = azurerm_network_security_group.nsg_sub_squid.id
}

resource "azurerm_subnet" "firewall-mgmt" {
  name = "AzureFirewallManagementSubnet"
  resource_group_name  = azurerm_resource_group.my_rg.name
  virtual_network_name = azurerm_virtual_network.vnet_hub.name
  address_prefixes = ["10.100.4.0/24"]
}

resource "azurerm_public_ip" "firewall-mgmt" {
  name                = "fw-mgmt"
  location            = azurerm_resource_group.my_rg.location
  resource_group_name = azurerm_resource_group.my_rg.name
  allocation_method   = "Static"
  sku                 = "Standard"
}

resource "azurerm_public_ip" "publicIP" {
  name                = "publicIP"
  location            = azurerm_resource_group.my_rg.location
  resource_group_name = azurerm_resource_group.my_rg.name
  allocation_method   = "Static"
  sku                 = "Standard"
}

resource "azurerm_firewall" "Firewall" {
  name                = "myfirewall"
  location            = azurerm_resource_group.my_rg.location
  resource_group_name = azurerm_resource_group.my_rg.name
  sku_name            = "AZFW_VNet"
  sku_tier            = "Basic"

management_ip_configuration {
    name                 = "management"
    subnet_id            = azurerm_subnet.firewall-mgmt.id
    public_ip_address_id = azurerm_public_ip.firewall-mgmt.id
   
  }
  
  ip_configuration {
    name                 = "configuration"
    subnet_id            = azurerm_subnet.azure_firewall_subnet.id
    public_ip_address_id = azurerm_public_ip.publicIP.id
 
  }

  depends_on = [
    azurerm_public_ip.publicIP
  ]
}








resource "azurerm_network_interface" "bastion_nic" {
  name                = "bastion-nic"
  location            = azurerm_resource_group.my_rg.location
  resource_group_name = azurerm_resource_group.my_rg.name

  ip_configuration {
    name                          = "bastion-nic-ipconfig"
    subnet_id                     = azurerm_subnet.sub_bastion.id
    private_ip_address_allocation = "Dynamic"
  }
}



resource "azurerm_linux_virtual_machine" "bastion_vm" {
  name                  = "bastion-vm"
  location            = azurerm_resource_group.my_rg.location
  resource_group_name = azurerm_resource_group.my_rg.name
  network_interface_ids = [azurerm_network_interface.bastion_nic.id]
  size                = "Standard_F2"
  admin_username      = "adminuser"
admin_ssh_key {
    username   = "adminuser"
    public_key = file("~/.ssh/id_rsa.pub")
  }


  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-jammy"
    sku       = "22_04-lts"
    version   = "latest"
  }
}


resource "azurerm_firewall_nat_rule_collection" "example" {
  name                = "testcollection"
  azure_firewall_name = azurerm_firewall.Firewall.name
  resource_group_name = azurerm_resource_group.my_rg.name
  priority            = 100
  action              = "Dnat"

  rule {
    name = "testrule"

    source_addresses = [
      "*",
    ]

    destination_ports = [
      "22",
    ]

    destination_addresses = [
      azurerm_public_ip.publicIP.ip_address
      
    ]

    translated_port = 22

    translated_address = azurerm_network_interface.bastion_nic.ip_configuration[0].private_ip_address

    protocols = [
      "TCP",
      "UDP",
    ]
  }
}




resource "azurerm_route_table" "custom_route_table" {
  name                = "custom-route-table"
 location            = azurerm_resource_group.my_rg.location
  resource_group_name = azurerm_resource_group.my_rg.name
}

resource "azurerm_route" "http_route" {
  name                   = "route-http"
  route_table_name       = azurerm_route_table.custom_route_table.name
  resource_group_name    = azurerm_resource_group.my_rg.name
  address_prefix         = "0.0.0.0/0"
  next_hop_type          = "VirtualAppliance"
  next_hop_in_ip_address = azurerm_firewall.Firewall.ip_configuration[0].private_ip_address
}
//association to subnet
resource "azurerm_subnet_route_table_association" "squid_subnet_association" {
  route_table_id = azurerm_route_table.custom_route_table.id
  subnet_id      = azurerm_subnet.sub_squid.id
}

resource "azurerm_firewall_network_rule_collection" "firewall_allow_traffic" {
  name                = "firewall_allow_traffic_network_collection"
  azure_firewall_name = azurerm_firewall.Firewall.name
  resource_group_name = azurerm_resource_group.my_rg.name
  priority            = 100
  action              = "Allow"

  rule {
    name = "allow_http_https_dns"

    source_addresses = [
      "*",
    ]

    destination_ports = [
      "53",
      "80",
      "443",
    ]
destination_addresses = [
      "*"
    ]

    protocols = [
      "TCP",
      "UDP",
    ]
  }
}

resource "azurerm_network_security_rule" "nsg_sub_squid_allow_inbound_http" {
  name                        = "Allow-HTTP"
  priority                    = 100
  direction                   = "Inbound"
  access                      = "Allow"
  protocol                    = "Tcp"
  source_port_range           = "*"
  destination_port_range      = "80"
  source_address_prefix       = "*"
  destination_address_prefix  = "*"
  resource_group_name         = azurerm_resource_group.my_rg.name
  network_security_group_name = azurerm_network_security_group.nsg_sub_squid.name
}

resource "azurerm_network_security_rule" "nsg_sub_squid_allow_inbound_https" {
  name                        = "Allow-HTTPS"
  priority                    = 110
  direction                   = "Inbound"
  access                      = "Allow"
  protocol                    = "Tcp"
  source_port_range           = "*"
  destination_port_range      = "443"
  source_address_prefix       = "*"
  destination_address_prefix  = "*"
  resource_group_name         = azurerm_resource_group.my_rg.name
  network_security_group_name = azurerm_network_security_group.nsg_sub_squid.name
}


resource "azurerm_network_security_rule" "nsg_sub_squid_allow_outbound_http" {
  name                        = "Allow-HTTP"
  priority                    = 100
  direction                   = "Outbound"
  access                      = "Allow"
  protocol                    = "Tcp"
  source_port_range           = "*"
  destination_port_range      = "80"
  source_address_prefix       = "*"
  destination_address_prefix  = "*"
  resource_group_name         = azurerm_resource_group.my_rg.name
  network_security_group_name = azurerm_network_security_group.nsg_sub_squid.name
}


resource "azurerm_network_security_rule" "nsg_sub_squid_allow_outbound_https" {
  name                        = "Allow-HTTPS"
  priority                    = 110
  direction                   = "Outbound"
  access                      = "Allow"
  protocol                    = "Tcp"
  source_port_range           = "*"
  destination_port_range      = "443"
  source_address_prefix       = "*"
  destination_address_prefix  = "*"
  resource_group_name         = azurerm_resource_group.my_rg.name
  network_security_group_name = azurerm_network_security_group.nsg_sub_squid.name
}

resource "azurerm_network_security_rule" "nsg_sub_squid_deny_all_outbound" {
  name                        = "Deny-All-Traffic"
  priority                    = 200
  direction                   = "Outbound"
  access                      = "Deny"
  protocol                    = "*"
  source_port_range           = "*"
  destination_port_range      = "*"
  source_address_prefix       = "*"
  destination_address_prefix  = "*"
  resource_group_name         = azurerm_resource_group.my_rg.name
  network_security_group_name = azurerm_network_security_group.nsg_sub_squid.name
}

resource "azurerm_network_security_rule" "nsg_sub_squid_deny_all_inbound" {
  name                        = "Deny-All-Traffic"
  priority                    = 200
  direction                   = "Inbound"
  access                      = "Deny"
  protocol                    = "*"
  source_port_range           = "*"
  destination_port_range      = "*"
  source_address_prefix       = "*"
  destination_address_prefix  = "*"
  resource_group_name         = azurerm_resource_group.my_rg.name
  network_security_group_name = azurerm_network_security_group.nsg_sub_squid.name
}

resource "azurerm_network_security_rule" "nsg_sub_squid_allow_inbound_ssh" {
  name                        = "Allow-SSH"
  priority                    = 101
  direction                   = "Inbound"
  access                      = "Allow"
  protocol                    = "Tcp"
  source_port_range           = "*"
  destination_port_range      = "22"
  source_address_prefix       = "*"
  destination_address_prefix  = "*"
  resource_group_name         = azurerm_resource_group.my_rg.name
  network_security_group_name = azurerm_network_security_group.nsg_sub_squid.name
}