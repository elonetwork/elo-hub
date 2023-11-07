module "vnet-hub" {
  source             = "./Modules/Vnet-hub/vnet"
  location           = var.location
  resourcegroup-name = var.resourcegroup-name
}

module "subnet-hub" {
  source               = "./Modules/Resources/subnet"
  for_each             = var.subnets_hub
  resource_group_name  = var.resourcegroup-name
  name                 = each.value["name"]
  virtual_network_name = module.vnet-hub.vnet-hub-object.vnet-name
  address_prefixes     = each.value["adress_prefixes"]
}

module "nsg_bastion" {
  source              = "./Modules/Resources/nsg"
  name                = "nsg_bastion"
  location            = var.location
  resource_group_name = var.resourcegroup-name
}

module "nsg_sequid" {
  source              = "./Modules/Resources/nsg"
  name                = "nsg_sequid"
  location            = var.location
  resource_group_name = var.resourcegroup-name
}

module "deny-all-inbound-rule-Bastion" {
  source                      = "./Modules/Resources/nsr"
  name                        = "deny-all-inbound-rule-Squid"
  priority                    = 1000
  direction                   = "Inbound"
  access                      = "Deny"
  resource_group_name         = var.resourcegroup-name
  network_security_group_name = module.nsg_bastion.nsg-name
}

module "deny-all-inbound-rule-Squid" {
  source                      = "./Modules/Resources/nsr"
  name                        = "deny-all-inbound-rule-Squid"
  priority                    = 1000
  direction                   = "Inbound"
  access                      = "Deny"
  resource_group_name         = var.resourcegroup-name
  network_security_group_name = module.nsg_sequid.nsg-name
}

module "allow-tcp-outbound-rule-bastion" {
  source = "./Modules/Resources/nsr"
   name                        = "allow-tcp-outbound-rule-bastion"
  priority                    = 100
  direction                   = "Outbound"
  access                      = "Allow"
  protocol                    = "Tcp"
  source_port_range           = "*"
  destination_port_range     = "22"
  source_address_prefix       = "*"
  destination_address_prefix  = "*"
  resource_group_name         = var.resourcegroup-name
  network_security_group_name = module.nsg_bastion.nsg-name
}

module "allow-tcp-inbound-rule-bastion" {
  source = "./Modules/Resources/nsr"
   name                        = "allow-tcp-inbound-rule-bastion"
  priority                    = 100
  direction                   = "Inbound"
  access                      = "Allow"
  protocol                    = "Tcp"
  source_port_range           = "*"
  destination_port_range     = "22"
  source_address_prefix       = "*"
  destination_address_prefix  = "*"
  resource_group_name         = var.resourcegroup-name
  network_security_group_name = module.nsg_bastion.nsg-name
}

module "allow-tcp-inbound-rule-squid" {
  source = "./Modules/Resources/nsr"
   name                        = "nsr_intsquid"
  priority                    = 100
  direction                   = "Inbound"
  access                      = "Allow"
  protocol                    = "Tcp"
  source_port_range           = "*"
  destination_port_range     = "22"
  source_address_prefix       = "*"
  destination_address_prefix  = "*"
  resource_group_name         = var.resourcegroup-name
  network_security_group_name = module.nsg_sequid.nsg-name
}


resource "azurerm_subnet_network_security_group_association" "assoss_subnet_bastion" {
  subnet_id                 = module.subnet-hub["subnet_1"].subnet_object.id
  network_security_group_id = module.nsg_bastion.nsg-object.id
}

resource "azurerm_subnet_network_security_group_association" "assoss_subnet_squid" {
  subnet_id                 = module.subnet-hub["subnet_3"].subnet_object.id
  network_security_group_id = module.nsg_sequid.nsg-object.id
}

module "public_ip_firwall" {
  source              = "./Modules/Resources/public-ip"
  name                = "public_ip_firwall"
  location            = var.location
  resource_group_name = var.resourcegroup-name
  allocation_method   = "Static"
  sku                 = "Standard"
}

module "firewall-mgmt" {
  source               = "./Modules/Resources/subnet"
  name                 = "AzureFirewallManagementSubnet"
  resource_group_name  = var.resourcegroup-name
  virtual_network_name = module.vnet-hub.vnet-hub-object.vnet-name
  address_prefixes     = ["10.100.4.0/24"]
}

module "public-ip-firewall-mgmt" {
  source              = "./Modules/Resources/public-ip"
  name                = "fw-mgmt"
  location            = var.location
  resource_group_name = var.resourcegroup-name
  allocation_method   = "Static"
  sku                 = "Standard"
}

module "firewall" {
  source                          = "./Modules/Vnet-hub/subnet-firewall/firewall"
  name                            = "firewall"
  location                        = var.location
  resource_group_name             = var.resourcegroup-name
  sku_name                        = "AZFW_VNet"
  sku_tier                        = "Basic"
  name_ip_configuration           = "configuration"
  subnet_id                       = module.subnet-hub["subnet_2"].subnet_object.id
  public_ip_address_id            = module.public_ip_firwall.publicip_object.id
  name_ip_management              = "management"
  subnet_id_management            = module.firewall-mgmt.subnet_object.id
  public_ip_address_id_management = module.public-ip-firewall-mgmt.publicip_object.id
}

resource "azurerm_network_interface" "app_interface" {
  name                = "app_interface"
  location            = var.location
  resource_group_name = var.resourcegroup-name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = module.subnet-hub["subnet_1"].subnet_object.id
    private_ip_address_allocation = "Dynamic"
  }
}

resource "tls_private_key" "linux_key" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "local_file" "linuxkey" {
  filename = "linuxkey.pem"
  content  = tls_private_key.linux_key.private_key_pem
}
module "vm_bastion" {
  source = "./Modules/Vnet-hub/subnet-bastion/vm-bastion"
   name                = "vm-bastion"
  location            = var.location
  resource_group_name = var.resourcegroup-name
   network_interface_ids = [
    azurerm_network_interface.app_interface.id,
  ]
  public_key = tls_private_key.linux_key.public_key_openssh
}

resource "azurerm_firewall_nat_rule_collection" "nat_rule_collection" {
  name                = "nat_rule_collection"
  priority            = 100
  azure_firewall_name = module.firewall.firewall_name
  action              = "Dnat"
  resource_group_name = var.resourcegroup-name

  rule {
    name = "testrule"

    source_addresses = ["*"]

    destination_ports = [
      "22",
    ]

    destination_addresses = [module.public_ip_firwall.publicip_object.ip_address]

    translated_port = 22

    translated_address = azurerm_network_interface.app_interface.ip_configuration[0].private_ip_address

    protocols = [
      "TCP",
    ]
  }
}



resource "azurerm_network_interface" "app_interface_squid" {
  name                = "app_interface_squid"
  location            = var.location
  resource_group_name = var.resourcegroup-name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = module.subnet-hub["subnet_3"].subnet_object.id
    private_ip_address_allocation = "Dynamic"
  }
}

module "vm_squid" {
  source = "./Modules/Vnet-hub/subnet-squid/vm-squid"
  name                          = "vm-squid"
  location                      = var.location
  resource_group_name           = var.resourcegroup-name
  network_interface_ids         = [azurerm_network_interface.app_interface_squid.id]
}

resource "azurerm_route_table" "squid_route" {
  name                = "squid_route"
  location            = var.location
  resource_group_name = var.resourcegroup-name
}

resource "azurerm_route" "http_route" {
  name                   = "route-http"
  route_table_name       = azurerm_route_table.squid_route.name
  resource_group_name    = var.resourcegroup-name
  address_prefix         = "0.0.0.0/0"
  next_hop_type          = "VirtualAppliance"
  next_hop_in_ip_address = module.firewall.firewall_object.ip_configuration[0].private_ip_address
}
resource "azurerm_subnet_route_table_association" "squid_subnet_association" {
  route_table_id = azurerm_route_table.squid_route.id
  subnet_id      = module.subnet-hub["subnet_3"].subnet_object.id
}

module "nsg-http-allow-outbound-squid" {
  source = "./Modules/Resources/nsr"
    name                        = "nsg-http-allow-outbound-squid"
  priority                    = 100
  direction                   = "Outbound"
  access                      = "Allow"
  protocol                    = "Tcp"
  source_port_range           = "*"
  destination_port_range      = "80"
  source_address_prefix       = "*"
  destination_address_prefix  = "*"
  resource_group_name         = var.resourcegroup-name
  network_security_group_name = module.nsg_sequid.nsg-name
}

module "nsg-htts-allow-outbound-squid" {
  source = "./Modules/Resources/nsr"
    name                        = "nsg-https-allow-outbound-squid"
   priority                    = 110
  direction                   = "Outbound"
  access                      = "Allow"
  protocol                    = "Tcp"
  source_port_range           = "*"
  destination_port_range      = "443"
  source_address_prefix       = "*"
  destination_address_prefix  = "*"
  resource_group_name         = var.resourcegroup-name
  network_security_group_name = module.nsg_sequid.nsg-name
}

module "nsg-deny-all-outbound-squid" {
  source = "./Modules/Resources/nsr"
    name                        = "nsg-deny-all-outbound-squid"
    priority                    = 200
  direction                   = "Outbound"
  access                      = "Deny"
  protocol                    = "*"
  source_port_range           = "*"
  destination_port_range      = "*"
  source_address_prefix       = "*"
  destination_address_prefix  = "*"
  resource_group_name         =var.resourcegroup-name
  network_security_group_name = module.nsg_sequid.nsg-name
}

resource "azurerm_firewall_network_rule_collection" "firewall_allow_traffic" {
  name                = "firewall_allow_traffic_network_collection"
  azure_firewall_name = module.firewall.firewall_name
  resource_group_name = var.resourcegroup-name
  priority            = 100
  action              = "Allow"

  rule {
    name = "allow_http_https_dns"

    source_addresses = [
      "*",
    ]

    destination_ports = [
      "53",
      "80",
      "443",
    ]

    destination_addresses = [
      "*"
    ]

    protocols = [
      "TCP",
      "UDP",
    ]
  }
}