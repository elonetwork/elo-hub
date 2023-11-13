
### - Create Network Security Groups -------------------------**
# NSG for firewall -- sub-firewall
resource "azurerm_network_security_group" "firewall" {
  name                = "firewall"
   location            = var.location
  resource_group_name = var.resource_group_name
}

# NSG  --> sub-bastion for bastion-vm
resource "azurerm_network_security_group" "nsg-sub-bastion" {
  name                = "nsg-sub-bastion"
  location            = var.location
  resource_group_name = var.resource_group_name

}

# NSG  --> sub-squide for squide-vm
resource "azurerm_network_security_group" "nsg-sub-squide" {
  name                = "nsg-sub-squide"
   location            = var.location
  resource_group_name = var.resource_group_name
}
#*********************************end