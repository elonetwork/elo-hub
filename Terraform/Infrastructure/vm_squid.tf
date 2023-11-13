resource "azurerm_network_interface" "app_interface_squid" {
  name                = var.name-network_interface-squid
  location            = var.location
  resource_group_name = var.resource_group_name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = module.subnet-squid.subnet_id
    private_ip_address_allocation = "Dynamic"
  }
}

resource "azurerm_virtual_machine" "vm_squid" {
  name                          = var.name-vm-squid
  location                      = var.location
  resource_group_name           = var.resource_group_name
  network_interface_ids         = [azurerm_network_interface.app_interface_squid.id]
  vm_size                       = var.vm-size-squid
  delete_os_disk_on_termination = true

  storage_os_disk {
    name              = "disk-squid"
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
    computer_name  = var.computer-name-squid
    admin_username = var.admin-username-vm-squid
    admin_password = var.password-vm-squid
  }

  os_profile_linux_config {
    disable_password_authentication = false
  }
}