resource "azurerm_linux_virtual_machine" "bastion_vm" {
  name                  = var.bastion_vm_name
  location              = var.location
  resource_group_name   = var.resource_group_name
  network_interface_ids = [azurerm_network_interface.bastion_nic.id]
  size                  = "Standard_F2"

  admin_username        = var.admin_username
  admin_ssh_key {
    username   = var.admin_username
    public_key = file("~/.ssh/id_rsa.pub")
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
  user_data = base64encode(templatefile("${path.module}/init-bastion-vm.tftpl",{
    service_principal_username      = var.aks_service_principal.client_id,
    service_principal_password      = var.aks_service_principal.client_secret,
    service_principal_tenant        = var.tenant_id,
    resource_group_name = var.resource_group_name,
    storage_account_name = var.storage_account_name,
    location = var.location,
    


  }))
}
