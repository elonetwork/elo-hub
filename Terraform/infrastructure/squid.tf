
resource "azurerm_linux_virtual_machine" "squid_vm" {
  name                            = var.squid_vm_name
  location                        = var.location
  resource_group_name             = var.resource_group_name
  network_interface_ids           = [azurerm_network_interface.squid_nic.id]
  size                            = var.squid_vm_size
  disable_password_authentication = var.squid_vm_disable_password_authentication

  admin_username = var.squid_vm_admin_username
  admin_password = var.squid_vm_admin_password

  os_disk {
    name                 = var.squid_vm_os_disk_name
    caching              = var.squid_vm_os_disk_caching
    storage_account_type = var.squid_vm_os_disk_storage_account_type
  }

  source_image_reference {
    publisher = var.squid_vm_source_image_publisher
    offer     = var.squid_vm_source_image_offer
    sku       = var.squid_vm_source_image_sku
    version   = var.squid_vm_source_image_version
  }

  /*user_data = base64encode(templatefile("${path.cwd}/../../scripts/init-squid-vm.tftpl", {
    address_prefixes = azurerm_subnet.sub_squid.address_prefixes
  }))*/


}

