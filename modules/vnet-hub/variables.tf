
### -Variables virtual network creation ------------------
variable "vnet_name" {
  description = "Name of the Virtual Network"
  type        = string
  default     = "vnet-hub"
}
variable "address_space" {
  description = "Address space for the Virtual Network"
  type        = list(string)
  default     = ["10.100.0.0/16"]
}
variable "location" {
  description = "Location of the Virtual Network"
  type        = string
  default     = "West US"
}
variable "resource_group_name" {
  description = "Name of the Resource Group"
  type        = string
  default     = "1-62e49a50-playground-sandbox"
}
### -----Variables subnets network creation ---------

### -----Variables nsg network creation ---------

### ----- Variables public ips network creation ---------

### ----- Variables bastion-VM network creation ---------

### ----- Variables squide-VM network creation ----------

### -----Variables firewall+ rt network creation ---------

