variable "vnet_hub_name" {
  type = string
  description = "Name of the VNet-Hub resource"
}
variable "address_space" {
  type = list(string)
  description = "Address space for the VNet-Hub"
}
variable "location" {
  type = string
  description = "Azure region where the VNet-Hub will be created"
}
variable "resource_group_name" {
  type        = string
  description = "Name of the Resource Group"
}