output "vnet_name" {
  description = "Output of the vnet_name variable"
  value       = var.vnet_name
}
output "address_space" {
  description = "Output of the address_space variable"
  value       = var.address_space
}
output "location" {
  description = "Output of the location variable"
  value       = var.location
}
output "resource_group_name" {
  description = "Output of the resource_group_name variable"
  value       = var.resource_group_name
}
output "public_ip_address" {
  value = azurerm_public_ip.public_ip.ip_address
}