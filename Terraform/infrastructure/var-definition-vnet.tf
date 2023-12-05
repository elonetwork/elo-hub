
variable "address_space" {
  description = "The address space for the virtual network"
  default     = ["10.0.0.0/16"]  # Replace with your default value
}

variable "hub_vnet_name" {
  description = "The name of the virtual network"
  default     = "hub-vnet"  # Replace with your default value
}