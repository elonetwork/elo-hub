resource "azurerm_virtual_machine" "vm_squid" {
  name                          = var.name
  location                      = var.location
  resource_group_name           = var.resource_group_name
  network_interface_ids         = var.network_interface_ids
  vm_size                       = "Standard_DS1_v2"
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
    computer_name  = "hostname-squid"
    admin_username = "yassine"
    admin_password = "OmgPassword123"
  }

  os_profile_linux_config {
    disable_password_authentication = false
  }
}