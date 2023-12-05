resource "azurerm_network_interface" "bastion_nic" {
  name                = var.bastion_nic_name
  location            = var.location
  resource_group_name = var.resource_group_name

  ip_configuration {
    name                          = "bastion-nic-ipconfig"
    subnet_id                     = azurerm_subnet.sub_bastion.id
    private_ip_address_allocation = "Dynamic"
  }
}


resource "azurerm_network_interface" "squid_nic" {
  name                = var.squid_nic_name
  location            = var.location
  resource_group_name = var.resource_group_name

  ip_configuration {
    name                          = var.squid_ip_configuration_name
    subnet_id                     = azurerm_subnet.sub_squid.id
    private_ip_address_allocation = "Dynamic"
  }
}

