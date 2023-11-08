
module "sub-firewall" {
  source              = "../../../../modules/subnet/"
  subnet_name         = "AzureFirewallSubnet"
  resource_group_name = var.resource_group_name
  network_name        = var.vnet_name
  address_prefixes    = ["10.100.0.0/24"]
}

module "firewall_public_ip" {
  source              = "../../../../modules/public_ip"
  name                = "firewall_public_ip"
  resource_group_name = var.resource_group_name
  location            = var.location
}

resource "azurerm_subnet" "firewall-mgmt" {
  name = "AzureFirewallManagementSubnet"
  resource_group_name  = var.resource_group_name
  virtual_network_name = var.vnet_name
  address_prefixes = ["10.100.4.0/24"]
}

resource "azurerm_public_ip" "firewall-mgmt" {
  name                = "fw-mgmt"
  location            = var.location
  resource_group_name = var.resource_group_name
  allocation_method   = "Static"
  sku                 = "Standard"
}

resource "azurerm_firewall" "elo-network" {
  name                = var.firewal_name
  location            = var.location
  resource_group_name = var.resource_group_name
  sku_name            = "AZFW_VNet"
  sku_tier            = "Basic"

  ip_configuration {
    name                 = "configuration"
    subnet_id            = module.sub-firewall.subnet_id
    public_ip_address_id = module.firewall_public_ip.id
  }

  management_ip_configuration {
    name                 = "management"
    subnet_id            = azurerm_subnet.firewall-mgmt.id
    public_ip_address_id = azurerm_public_ip.firewall-mgmt.id
  }
}


resource "azurerm_firewall_nat_rule_collection" "nat_rule_collection" {
  name                = "nat_rule_collection"
  priority            = 100
  azure_firewall_name = azurerm_firewall.elo-network.name
  action              = "Dnat"
  resource_group_name = var.resource_group_name

  rule {
    name = "testrule"

    source_addresses = ["*"]

    destination_ports = [
      "22",
    ]

    destination_addresses = [module.firewall_public_ip.ip]

    translated_port = 22

    translated_address = var.bastion_vm_ip

    protocols = [
      "TCP",
    ]
  }

}



resource "azurerm_firewall_network_rule_collection" "example" {
  name                = "allow-https"
  azure_firewall_name = azurerm_firewall.elo-network.name
  resource_group_name = var.resource_group_name
  priority            = 101
  action              = "Allow"

  rule {
    name = "testrule"

    source_addresses = [
      "0.0.0.0/0",
    ]

    destination_ports = [
      "53","443","80"
    ]

    destination_addresses = [
      "0.0.0.0/0",
    ]

    protocols = ["Any"]
  }
}



output "firewall_public_ip" {
  value = module.firewall_public_ip.ip
}

output "firewall_mgm_public_ip" {
  value = azurerm_public_ip.firewall-mgmt.ip_address
}

output "firewall_private_ip" {
  value = azurerm_firewall.elo-network.ip_configuration[0].private_ip_address
}
