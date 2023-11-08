module "sub-squide" {
  source              = "../../../../modules/subnet/"
  subnet_name         = var.subnet_name
  resource_group_name = var.resource_group_name
  network_name        = var.vnet_name
  address_prefixes    = var.address_prefixes
}

module "nsg-sub-squide" {
  source              = "../../../../modules/nsg/"
  subnet_id           = module.sub-squide.subnet_id
  nsg_name            = "nsg-${var.subnet_name}"
  nsg_location        = var.location
  resource_group_name = var.resource_group_name
}


resource "azurerm_network_interface" "elo-network" {
  name                = "VMNic-${var.subnet_name}"
  location            = var.location
  resource_group_name = var.resource_group_name

  ip_configuration {
    name                          = "ipconfig-${var.subnet_name}"
    subnet_id                     = module.sub-squide.subnet_id
    private_ip_address_allocation = "Dynamic"
  }
}

resource "azurerm_virtual_machine" "elo-network" {
  name                  = "VM-${var.subnet_name}"
  location              = var.location
  resource_group_name   = var.resource_group_name
  network_interface_ids = [azurerm_network_interface.elo-network.id]
  vm_size               = "Standard_DS1_v2"
  delete_os_disk_on_termination = true

  storage_os_disk {
    name              = "osdisk-${var.subnet_name}"
    caching           = "ReadWrite"
    create_option     = "FromImage"
    managed_disk_type = "Standard_LRS"
  }

  storage_image_reference {
    publisher = "Canonical"
    offer     = "UbuntuServer"
    sku       = "18.04-LTS"
    version   = "latest"
  }

  os_profile {
    computer_name  = "hostname-${var.subnet_name}"
    admin_username = "usrbadr"
    admin_password = "Password@123"
  }

  os_profile_linux_config {
    disable_password_authentication = false
  }
}

resource "azurerm_network_security_rule" "nsr_out" {
  name                        = "nsr_out-${var.subnet_name}"
  priority                    = 100
  direction                   = "Outbound"
  access                      = "Allow"
  protocol                    = "Tcp"
  source_port_range           = "*"
  destination_port_ranges     = ["22"]
  source_address_prefix       = "*"
  destination_address_prefix  = "*"
  resource_group_name         = var.resource_group_name
  network_security_group_name = module.nsg-sub-squide.nsg_name
}

resource "azurerm_network_security_rule" "nsr_in" {
  name                        = "nsr_int-${var.subnet_name}"
  priority                    = 100
  direction                   = "Inbound"
  access                      = "Allow"
  protocol                    = "Tcp"
  source_port_range           = "*"
  destination_port_ranges     = ["22"]
  source_address_prefix       = "*"
  destination_address_prefix  = "*"
  resource_group_name         = var.resource_group_name
  network_security_group_name = module.nsg-sub-squide.nsg_name
}

output "vm_private_ip" {
  value = azurerm_network_interface.elo-network.ip_configuration[0].private_ip_address
}

resource "azurerm_route_table" "squid_route_table" {
  name                = "squid-vm-route-table"
  location            = var.location
  resource_group_name = var.resource_group_name
}

resource "azurerm_route" "squid_route" {
  name                   = "default"
  route_table_name       = azurerm_route_table.squid_route_table.name
  resource_group_name    = azurerm_route_table.squid_route_table.resource_group_name
  address_prefix         = "0.0.0.0/0"
  next_hop_type          = "VirtualAppliance"
  next_hop_in_ip_address = var.firewall_private_ip
}

resource "azurerm_subnet_route_table_association" "squid_association" {
  subnet_id      = module.sub-squide.subnet_id
  route_table_id = azurerm_route_table.squid_route_table.id
}

