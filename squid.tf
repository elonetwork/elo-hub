resource "azurerm_network_interface" "squid_nic" {
  name                = "squid-nic"
  location            = azurerm_resource_group.my_rg.location
  resource_group_name = azurerm_resource_group.my_rg.name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.sub_squid.id
    private_ip_address_allocation = "Dynamic"
  }
}
resource "azurerm_linux_virtual_machine" "squid_vm" {
  name                            = "squid-vm"
  location                        = azurerm_resource_group.my_rg.location
  resource_group_name             = azurerm_resource_group.my_rg.name
  network_interface_ids           = [azurerm_network_interface.squid_nic.id]
  size                            = "Standard_F2"
  disable_password_authentication = false

  admin_username = "adminelo"
  admin_password = "@TE*$sx"

  os_disk {
    name                 = "squid-os-disk"
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "UbuntuServer"
    sku       = "18.04-LTS"
    version   = "latest"
  }

  user_data = base64encode(file("${path.module}/script.tftpl"))

  depends_on = [ azurerm_subnet_route_table_association.squid_subnet_association]
}
 
