
### -----------------------Variables virtual network creation ------------------
variable "vnet_name" {
  description = "Name of the Virtual Network"
  type        = string
  default     = "vnet-prd"
}

variable "address_space" {
  description = "Address space for the Virtual Network"
  type        = list(string)
  default     = ["10.102.0.0/16"]
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
