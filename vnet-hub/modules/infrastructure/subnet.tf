
### - Create subnets -------------------------------**

# Subnet for firewall -- AzureFirewallSubnet
resource "azurerm_subnet" "sub-firewall" {
  name                 = "AzureFirewallSubnet"
  resource_group_name  = var.resource_group_name
  virtual_network_name = var.vnet_hub_name
  address_prefixes     = ["10.100.1.0/24"]
}
# Subnet for firewall ip management -- AzureFirewallManagementSubnet
resource "azurerm_subnet" "sub-firewall-management" {
  name                 = "AzureFirewallManagementSubnet"
  resource_group_name  = var.resource_group_name
  virtual_network_name = var.vnet_hub_name
  address_prefixes     = ["10.100.2.0/24"]
}
# Subnet for bastion vm 
resource "azurerm_subnet" "sub-bastion" {
  name                 = "sub-bastion"
  resource_group_name  = var.resource_group_name
  virtual_network_name = var.vnet_hub_name
  address_prefixes     = ["10.100.3.0/24"]
}
# Subnet for vm squide
resource "azurerm_subnet" "sub-squide" {
  name                 = "sub-squide"
  resource_group_name  = var.resource_group_name
  virtual_network_name = var.vnet_hub_name
  address_prefixes     = ["10.100.4.0/24"]
}