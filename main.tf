
locals {
  resource_group="1-e9480bba-playground-sandbox"
  location="East US"  
}

resource "azurerm_storage_account" "storage_account" {
  name                     = "terraformstorebadr"
  resource_group_name      = "1-e9480bba-playground-sandbox"
  location                 = "East US"
  account_tier             = "Standard"
  account_replication_type = "LRS"
  allow_blob_public_access = true
}

# Here we are creating a container in the storage account
resource "azurerm_storage_container" "data" {
  name                  = "tfstate"
  storage_account_name  = "terraformstorebadr"
  container_access_type = "private"
}


resource "azurerm_virtual_network" "app_network" {
  name                = "vnet-hub"
  location            = "East US" 
  resource_group_name = "1-e9480bba-playground-sandbox"
  address_space       = ["10.100.0.0/16"]  
  
}

resource "azurerm_subnet" "Azure_Bastion_Subnet" {
  name                 = "AzureBastionSubnet"
  resource_group_name  = "1-e9480bba-playground-sandbox"
  virtual_network_name = azurerm_virtual_network.app_network.name
  address_prefixes     = ["10.100.2.0/24"]
  depends_on = [
    azurerm_virtual_network.app_network
  ]
}

resource "azurerm_subnet" "SubnetC" {
  name                 = "SubnetSquide"
  resource_group_name  = "1-e9480bba-playground-sandbox"
  virtual_network_name = azurerm_virtual_network.app_network.name
  address_prefixes     = ["10.100.3.0/24"]
  depends_on = [
    azurerm_virtual_network.app_network
  ]
}

// This subnet is meant for the Azure Bastion service
resource "azurerm_subnet" "SubnetA" {
  name                 = "SubnetFirewall"
  resource_group_name  = "1-e9480bba-playground-sandbox"
  virtual_network_name = azurerm_virtual_network.app_network.name
  address_prefixes     = ["10.100.1.0/24"]
  depends_on = [
    azurerm_virtual_network.app_network
  ]
}

resource "azurerm_network_interface" "app_interface" {
  name                = "app-interface"
  location            = "East US" 
  resource_group_name = "1-e9480bba-playground-sandbox"

  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.SubnetA.id
    private_ip_address_allocation = "Dynamic"
  }

  depends_on = [
    azurerm_virtual_network.app_network,
    azurerm_subnet.SubnetA
  ]
}

resource "azurerm_windows_virtual_machine" "app_vm" {
  name                = "appvm"
  resource_group_name = "1-e9480bba-playground-sandbox"
  location            = "East US"
  size                = "Standard_D2s_v3"
  admin_username      = "demousr"
  admin_password      = "Azure@123"  
  network_interface_ids = [
    azurerm_network_interface.app_interface.id,
  ]

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "MicrosoftWindowsServer"
    offer     = "WindowsServer"
    sku       = "2019-Datacenter"
    version   = "latest"
  }

  depends_on = [
    azurerm_network_interface.app_interface
  ]
}



resource "azurerm_network_security_group" "app_nsg" {
  name                = "nsg-sub-bastion"
  location            = "East US" 
  resource_group_name = "1-e9480bba-playground-sandbox"

# We are creating a rule to allow traffic on port 3389
  security_rule {
    name                       = "Allow_HTTP"
    priority                   = 200
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "3389"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }
}

resource "azurerm_network_security_group" "app_nsg1" {
  name                = "nsg-sub-firewall"
  location            = "East US" 
  resource_group_name = "1-e9480bba-playground-sandbox"

# We are creating a rule to allow traffic on port 3389
  security_rule {
    name                       = "Allow_HTTP"
    priority                   = 200
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "3389"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }
}

resource "azurerm_network_security_group" "app_nsg2" {
  name                = "nsg-sub-squid"
  location            = "East US" 
  resource_group_name = "1-e9480bba-playground-sandbox"

# We are creating a rule to allow traffic on port 3389
  security_rule {
    name                       = "Allow_HTTP"
    priority                   = 200
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "3389"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }
}

#resource "azurerm_subnet_network_security_group_association" "nsg_association" {
#subnet_id                 = azurerm_subnet.SubnetA.id
#network_security_group_id = azurerm_network_security_group.app_nsg.id
#depends_on = [
#  azurerm_network_security_group.app_nsg
# ]
#}


resource "azurerm_subnet_network_security_group_association" "nsg_association2" {
  subnet_id                 = azurerm_subnet.SubnetC.id
  network_security_group_id = azurerm_network_security_group.app_nsg2.id
  depends_on = [
    azurerm_network_security_group.app_nsg2
  ]
}


resource "azurerm_public_ip" "bastion_ip" {
  name                = "bastion-ip"
  location            = "East US"
  resource_group_name = "1-e9480bba-playground-sandbox"
  allocation_method   = "Static"
  sku                 = "Standard"
}

resource "azurerm_bastion_host" "app_bastion" {
  name                = "app-bastion"
  location            = "East US" 
  resource_group_name = "1-e9480bba-playground-sandbox"

  ip_configuration {
    name                 = "configuration"
    subnet_id            = azurerm_subnet.Azure_Bastion_Subnet.id
    public_ip_address_id = azurerm_public_ip.bastion_ip.id
  }

  depends_on=[
    azurerm_subnet.Azure_Bastion_Subnet,
    azurerm_public_ip.bastion_ip
  ]
}

resource "azurerm_public_ip" "vm_jump_pip" {
  name                = "pip-jump"
  location            = "East US"
  resource_group_name = "1-e9480bba-playground-sandbox"
  allocation_method   = "Static"
  sku                 = "Standard"
}

resource "azurerm_firewall_policy" "azfw_policy" {
  name                     = "azfw-policy"
  resource_group_name = "1-e9480bba-playground-sandbox"
  location            = "East US"
  sku                      = var.firewall_sku_tier
  threat_intelligence_mode = "Alert"
}

resource "azurerm_firewall" "fw" {
  name                = "azfw"
  location            = "East US"
  resource_group_name = "1-e9480bba-playground-sandbox"
  sku_name            = "AZFW_VNet"
  sku_tier            = var.firewall_sku_tier
  zones               = ["1", "2", "3"]
 
  firewall_policy_id = azurerm_firewall_policy.azfw_policy.id
}
