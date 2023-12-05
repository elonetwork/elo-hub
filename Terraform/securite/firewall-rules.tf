resource "azurerm_firewall_nat_rule_collection" "firewall_dnat_collection" {
  name                = var.firewall_nat_rule_collection_name
  azure_firewall_name = azurerm_firewall.hub_firewall.name
  resource_group_name = var.resource_group_name
  priority            = 100
  action              = "Dnat"

  rule {
    name = "testrule"

    source_addresses = [
      "*",
    ]

    destination_ports = [
      "22",
    ]

    destination_addresses = [
      azurerm_public_ip.firewall_public_ip.ip_address
    ]

    translated_port = 22

    translated_address = var.bastion_private_ip

    protocols = var.firewall_nat_protocols
  }
}

resource "azurerm_firewall_network_rule_collection" "firewall_network_rule_allow_traffic" {
  name                = var.firewall_network_rule_collection_name
  azure_firewall_name = azurerm_firewall.hub_firewall.name
  resource_group_name = var.resource_group_name
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

    protocols = var.firewall_network_protocols
  }
}

# view this article about the azure devops and azure firewall :
# https://developercommunity.visualstudio.com/t/self-hosted-windows-agents-firewall-ports/983093

resource "azurerm_firewall_application_rule_collection" "firewall_application_rule_collection" {
  name                = var.firewall_application_rule_collection_name
  azure_firewall_name = azurerm_firewall.hub_firewall.name
  resource_group_name = var.resource_group_name
  priority            = 100
  action              = "Allow"

  rule {
    name = "allow_azure_devops"

    source_addresses = [
      "*",
    ]

    target_fqdns = [
      "dev.azure.com",
      "*dev.azure.com"
    ]

    protocol {
      port = "443"
      type = "Https"
    }
  }
}