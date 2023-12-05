variable "firewall_public_ip_name" {
  description = "Name of the public IP for the firewall"
  type        = string
  default     = "firewall_ip"
}

variable "firewall_mgmt_public_ip_name" {
  description = "Name of the public IP for firewall management"
  type        = string
  default     = "fw-mgmt"
}

variable "public_ip_allocation_method" {
  description = "The allocation method for the public IP"
  type        = string
  default     = "Static"
}

variable "public_ip_sku" {
  description = "The SKU for the public IP"
  type        = string
  default     = "Standard"
}

variable "firewall_name" {
  description = "Name of the Azure Firewall"
  type        = string
  default     = "hub_firewall"
}

variable "firewall_sku_name" {
  description = "Name of the SKU for the Azure Firewall"
  type        = string
  default     = "AZFW_VNet"
}

variable "firewall_sku_tier" {
  description = "Tier of the SKU for the Azure Firewall"
  type        = string
  default     = "Basic"
}

variable "sub_firewall_id" {
  
}
variable "firewall-mgmt_id" {
  
}

