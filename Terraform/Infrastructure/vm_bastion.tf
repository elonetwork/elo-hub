resource "azurerm_network_interface" "app_interface" {
  name                = var.name-network_interface-bastion
  location            = var.location
  resource_group_name = var.resource_group_name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = module.subnet-bastion.subnet_id
    private_ip_address_allocation = "Dynamic"
  }
}
resource "tls_private_key" "linux_key" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "local_file" "linuxkey" {
  filename = var.filename-key
  content  = tls_private_key.linux_key.private_key_pem
}

resource "azurerm_linux_virtual_machine" "vm_bastion" {
  name                = var.name-vm-bastion
  location            = var.location
  resource_group_name = var.resource_group_name
  size                = var.size-vm-bastion
  admin_username      = var.admin-username-vm-bastion
  network_interface_ids = [azurerm_network_interface.app_interface.id]
 

  admin_ssh_key {
    username   = var.admin-username-vm-bastion
    public_key = tls_private_key.linux_key.public_key_openssh
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