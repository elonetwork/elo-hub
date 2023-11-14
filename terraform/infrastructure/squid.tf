resource "azurerm_network_interface" "interface-squid" {
  depends_on = [ module.sub-squide ]
  name                = var.interface_squid_name
  location            = var.location
  resource_group_name = var.resource_group_name

  ip_configuration {
    name                          = var.interace_squid_ip_config_name
    subnet_id                     = module.sub-squide.id
    private_ip_address_allocation = var.interace_squid_ip_config_private_ip_allocation
  }
}

resource "azurerm_virtual_machine" "vm-squid" {
  depends_on = [ azurerm_network_interface.interface-squid ]
  name                          = var.squid_vm_name
  location                      = var.location
  resource_group_name           = var.resource_group_name
  network_interface_ids         = [azurerm_network_interface.interface-squid.id]
  vm_size                       = var.squid_vm_size
  delete_os_disk_on_termination = true

  storage_os_disk {
    name              = var.squid_storage_os_disk_name
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
    computer_name  = var.squid_computer_name
    admin_username = var.squid_username
    admin_password = var.squid_password
  }

  os_profile_linux_config {
    disable_password_authentication = false
  }
}