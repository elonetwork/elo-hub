output "public_ip_name" {
  value = azurerm_public_ip.public_ip.name
}

output "publicip_adress" {
  value = azurerm_public_ip.public_ip.ip_address
}

output "publicip_object" {
  value = azurerm_public_ip.public_ip
}