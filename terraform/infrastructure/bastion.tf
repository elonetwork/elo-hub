resource "azurerm_network_interface" "interface-bastion" {
  depends_on = [ module.sub-bastion ]
  name                = var.interface_bastion_name
  location            = var.location
  resource_group_name = var.resource_group_name

  ip_configuration {
    name                          = var.interace_bastion_ip_config_name
    subnet_id                     = module.sub-bastion.id
    private_ip_address_allocation = var.interace_bastion_ip_config_private_ip_allocation
  }
}

resource "azurerm_virtual_machine" "vm-bastion" {
  depends_on = [ azurerm_network_interface.interface-bastion ]
  name                          = var.bastion_vm_name
  location                      = var.location
  resource_group_name           = var.resource_group_name
  network_interface_ids         = [azurerm_network_interface.interface-bastion.id]
  vm_size                       = var.bastion_vm_size
  delete_os_disk_on_termination = true
  
  storage_os_disk {
    name              = var.bastion_storage_os_disk_name
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
    computer_name  = var.bastion_computer_name
    admin_username = var.bastion_username
  }

  os_profile_linux_config {
    disable_password_authentication = true
    ssh_keys {
      path     = "/home/${var.bastion_username}/.ssh/authorized_keys"
      key_data = var.ssh_public_key
    }
  }
}