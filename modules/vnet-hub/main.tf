

### Create Virtual Network vnet-hub  -------------------------**
resource "azurerm_virtual_network" "vnet-hub" {
  name                = var.vnet_name
  address_space       = var.address_space
  location            = var.location
  resource_group_name = var.resource_group_name
}
#*********************************end


### - Create subnets -------------------------------**
#
# Subnet for firewall -- AzureFirewallSubnet
resource "azurerm_subnet" "sub-firewall" {
  name                 = "AzureFirewallSubnet"
  resource_group_name  = var.resource_group_name
  virtual_network_name = var.vnet_name
  address_prefixes     = ["10.100.1.0/24"]
}
# Subnet for firewall ip management -- AzureFirewallManagementSubnet
resource "azurerm_subnet" "sub-firewall-management" {
  name                 = "AzureFirewallManagementSubnet"
  resource_group_name  = var.resource_group_name
  virtual_network_name = var.vnet_name
  address_prefixes     = ["10.100.2.0/24"]
}
# Subnet for bastion vm 
resource "azurerm_subnet" "sub-bastion" {
  name                 = "sub-bastion"
  resource_group_name  = var.resource_group_name
  virtual_network_name = var.vnet_name
  address_prefixes     = ["10.100.3.0/24"]
}
# Subnet for vm squide
resource "azurerm_subnet" "sub-squide" {
  name                 = "sub-squide"
  resource_group_name  = var.resource_group_name
  virtual_network_name = var.vnet_name
  address_prefixes     = ["10.100.4.0/24"]
}
#*********************************end


### - Create Network Security Groups -------------------------**
#
# NSG for firewall -- sub-firewall
resource "azurerm_network_security_group" "firewall" {
  name                = "firewall"
  location            = var.location
  resource_group_name = var.resource_group_name
}

# NSG  --> sub-bastion for bastion-vm
resource "azurerm_network_security_group" "nsg-sub-bastion" {
  name                = "nsg-sub-bastion"
  location            = var.location
  resource_group_name = var.resource_group_name

}

# NSG  --> sub-squide for squide-vm
resource "azurerm_network_security_group" "nsg-sub-squide" {
  name                = "nsg-sub-squide"
  location            = var.location
  resource_group_name = var.resource_group_name
}
#*********************************end

### Create Network Security Group associations for subnets-------------------------**
# associate  --> nsg firewall with subnet firewall
#
#--> firewall dones accept associetion by default he has his own netzork security
#
# associate  --> nsg bastion with subnet bastion
resource "azurerm_subnet_network_security_group_association" "bastion" {
  subnet_id                 = azurerm_subnet.sub-bastion.id
  network_security_group_id = azurerm_network_security_group.nsg-sub-bastion.id
}
# associate  --> nsg squide with subnet squide
resource "azurerm_subnet_network_security_group_association" "squide" {
  subnet_id                 = azurerm_subnet.sub-squide.id
  network_security_group_id = azurerm_network_security_group.nsg-sub-squide.id
}
#*********************************end

#-------------------*****************************-------------#

## Define the public IPs for the management IP and Pulic ip configuration -- for firewall
resource "azurerm_public_ip" "management_public_ip" {
  name                = "management-public-ip"
  location            = var.location
  resource_group_name = var.resource_group_name
  allocation_method   = "Static"
  sku                 = "Standard"
}
resource "azurerm_public_ip" "public_ip" {
  name                = "open_ip"
  location            = var.location
  resource_group_name = var.resource_group_name
  allocation_method   = "Static"
  sku                 = "Standard"
}
#*********************************end

### ------------------------- Create an Azure Bastion VM
resource "azurerm_linux_virtual_machine" "bastion" {
  name                  = "bastion-vm"
  location              = var.location
  resource_group_name   = var.resource_group_name
  network_interface_ids = [azurerm_network_interface.bastion_nic.id]
  size                  = "Standard_B2ms"

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "UbuntuServer"
    sku       = "18.04-LTS"
    version   = "latest"
  }
  admin_username                  = "seddine"
  disable_password_authentication = true
  admin_ssh_key {
    username   = "seddine"
    public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDIhPEwjdKy2KxRfCZ9DmUu99PSOfmbgWik/is0xNXNDYxGKAY5l7RqNnh+rOnKTF5Ua7qJWqCTG73/YSWZorOC8JkTJiOyCU3/iF9Sgt1d7gctIu8MVewe8xsUOuEypBQGBQmqvIHRDdYWRy/dV6zU/4mYE4HM+eYG8UfYsPoc0DrkqwlvRlacRxoUbGbpoUTPfx071BKGmz9cZh89shyRS/iVT6WA+eBgwu+AtQONKECU3CRyu/YWfLXOHPkV3rOUFBkEO65SZzFkBr2au7IXh4BK3pBcI/rdXRlJKrxYDwRgFG0AywWlvgpH5FLq4d+AywYvQO0ySFG/GUqrZRGj seddine"
  }
}
# Create a network interface for the Bastion-vm
resource "azurerm_network_interface" "bastion_nic" {
  name                = "bastion-nic"
  location            = var.location
  resource_group_name = var.resource_group_name

  ip_configuration {
    name                          = "bastion-ipconfig"
    subnet_id                     = azurerm_subnet.sub-bastion.id
    private_ip_address_allocation = "Dynamic"
  }
}
# Network Security Group rule to allow SSH traffic to Bastion
resource "azurerm_network_security_rule" "allow_ssh_bastion" {
  name                        = "allow_ssh_bastion"
  priority                    = 1001
  direction                   = "Inbound"
  access                      = "Allow"
  protocol                    = "Tcp"
  source_port_range           = "*"
   destination_port_ranges     =["22"]
  source_address_prefix       = "*"
  destination_address_prefix  = "*"
  resource_group_name         = var.resource_group_name
  network_security_group_name = azurerm_network_security_group.nsg-sub-bastion.name
}

# resource "azurerm_network_security_rule" "allow_ssh_bastion_outbound" {
#   name                        = "allow_ssh_bastion_outbound"
#   priority                    = 1002
#   direction                   = "Outbound"
#   access                      = "Deny"
#   protocol                    = "*"
#   source_port_range           = "*"
#   destination_port_range      = "*"
#   source_address_prefix       = "*"
#   destination_address_prefix  = "*"
#   resource_group_name         = var.resource_group_name
#   network_security_group_name = azurerm_network_security_group.nsg-sub-bastion.name
# }
#*********************************end

### ------------------------- Create a Virtual Machine for Squide
resource "azurerm_linux_virtual_machine" "squide-vm" {
  name                  = "squide-vm"
  location              = var.location
  resource_group_name   = var.resource_group_name
  network_interface_ids = [azurerm_network_interface.squide_nic.id]
  size                  = "Standard_B2ms"

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "UbuntuServer"
    sku       = "18.04-LTS"
    version   = "latest"
  }
  
  admin_username                  = "seddinesq"
  admin_password                  = "Passtest**"
  disable_password_authentication = false
  custom_data = base64encode(file("/modules/vnet-hub/init_squid.sh"))

}

# Create a network interface for the Squide VM
resource "azurerm_network_interface" "squide_nic" {
  name                = "squide-nic"
  location            = var.location
  resource_group_name = var.resource_group_name

  ip_configuration {
    name                          = "squide-ipconfig"
    subnet_id                     = azurerm_subnet.sub-squide.id
    private_ip_address_allocation = "Dynamic"
  }
}

resource "azurerm_network_security_rule" "allow_ssh_from_bastion" {
  name                        = "allow-ssh-from-bastion"
  priority                    = 1002
  direction                   = "Inbound"
  access                      = "Allow"
  protocol                    = "Tcp"
  source_port_range           = "22"
  destination_port_range      = "22"
  source_address_prefix       = azurerm_network_interface.squide_nic.ip_configuration[0].private_ip_address
  destination_address_prefix  = azurerm_network_interface.bastion_nic.ip_configuration[0].private_ip_address
  resource_group_name         = var.resource_group_name
  network_security_group_name = azurerm_network_security_group.nsg-sub-squide.name
}
#*********************************end


# Define the Azure Firewall with a management IP configuration
resource "azurerm_firewall" "firewall" {
  name                = "firewall"
  resource_group_name = var.resource_group_name
  location            = var.location
  sku_name            = "AZFW_VNet"
  sku_tier            = "Basic"

  ip_configuration {
    name                 = "firewall-ip-configuration"
    subnet_id            = azurerm_subnet.sub-firewall.id
    public_ip_address_id = azurerm_public_ip.public_ip.id
  }
  management_ip_configuration {
    name                 = "management-ip-config"
    subnet_id            = azurerm_subnet.sub-firewall-management.id
    public_ip_address_id = azurerm_public_ip.management_public_ip.id
  }
}
# forwarding traffic to bastion vm trought firewall dnat rule
resource "azurerm_firewall_nat_rule_collection" "dnat" {
  name                = "ssh-dnat-rule"
  azure_firewall_name = azurerm_firewall.firewall.name
  resource_group_name = var.resource_group_name
  priority            = 110
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
     azurerm_public_ip.public_ip.ip_address
    ]

    translated_port = 22

    translated_address = azurerm_network_interface.bastion_nic.ip_configuration[0].private_ip_address

    protocols = [
      "TCP"
    ]
  }
}

# route for traffic to go through the Azure Firewall
resource "azurerm_route_table" "firewall_rt" {
  name                = "firewall-route-table"
  resource_group_name = var.resource_group_name
  location            = var.location
}
resource "azurerm_subnet_route_table_association" "firewall_association" {
  subnet_id      = azurerm_subnet.sub-squide.id
  route_table_id = azurerm_route_table.firewall_rt.id
}

# Define a route for all traffic to go through the Azure Firewall
resource "azurerm_route" "firewall_route" {
  name                   = "firewall-route"
  resource_group_name    = var.resource_group_name
  route_table_name       = azurerm_route_table.firewall_rt.name
  address_prefix         = "0.0.0.0/0"
  next_hop_type          = "VirtualAppliance"
  next_hop_in_ip_address = azurerm_firewall.firewall.ip_configuration.0.private_ip_address
}
#*********************************end