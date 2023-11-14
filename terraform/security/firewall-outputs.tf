output "firewall_public_ip" {
  value = module.public_ip_firewall.ip
}

# output "firewall_private_ip" {
#   value = azurerm_firewall.elo-network.ip_configuration[0].private_ip_address
# }