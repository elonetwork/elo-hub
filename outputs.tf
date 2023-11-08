# output.tf in the root module

output "vnet_name" {
  description = "vnet hub name"
  value       = module.vnet-hub.vnet_name
}

output "address_space" {
  description = "vnet hub address space"
  value       = module.vnet-hub.address_space
}

output "location" {
  description = "vnet hub location"
  value       = module.vnet-hub.location
}

output "child_resource_group_name" {
  description = "vnet hub groupe name"
  value       = module.vnet-hub.resource_group_name
}
output "public_ip_address" {
  description = "vnet hub groupe name"
  value       = module.vnet-hub.public_ip_address
}
