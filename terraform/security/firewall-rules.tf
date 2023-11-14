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

    destination_addresses = [module.public_ip_firewall.ip]

    translated_port = 22

    translated_address = var.bastion_private_ip

    protocols = [
      "TCP",
    ]
  }

}


resource "azurerm_firewall_network_rule_collection" "FNR_allow_web" {
  name                = "FNR_allow_web"
  azure_firewall_name = azurerm_firewall.elo-network.name
  resource_group_name = var.resource_group_name
  priority            = 101
  action              = "Allow"

  rule {
    name = "allow_web"

    source_addresses = [
      var.squid_private_ip,
      var.bastion_private_ip
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