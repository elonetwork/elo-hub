variable "virtual_network_name" {
  type        = string
  description = "Name of the Azure Virtual Network"
}
variable "virtual_network_id" {

}
variable "location" {
  type        = string
  description = "Location of Azure resources"
}

variable "subnet_address_prefixes" {
  type        = list(string)
  description = "Address prefixes for the Azure Subnet Network"
}
variable "env_name" {
  type        = string
  description = "Environment name prefix (e.g., prd, mgm)"
}

variable "environement" {
  type        = string
  description = "Environment name  (e.g., production, management)"
}


variable "resource_group_name" {
  type        = string
  description = "Name of the Azure Resource Group"
}


variable "aks_service_principal" {
  type = map(string)
}

variable "hub_vnet_id" {
  type = string
}

