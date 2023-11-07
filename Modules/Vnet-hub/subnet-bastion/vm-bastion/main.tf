resource "azurerm_linux_virtual_machine" "vm_bastion" {
  name                = var.name
  location            = var.location
  resource_group_name = var.resource_group_name
  size                = "Standard_F2"
  admin_username      = "adminuser"
  network_interface_ids = var.network_interface_ids
 

  admin_ssh_key {
    username   = "adminuser"
    public_key = var.public_key
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