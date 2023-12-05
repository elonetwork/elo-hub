variable "resource_group_name" {
  description = "Name of the resource group where the Application Gateway will be created."
}

variable "location" {
  description = "Azure region where the Application Gateway will be deployed."
}

variable "app_gateway_name" {
  description = "Name of the Azure Application Gateway."
}

variable "subnet_id" {
  description = "ID of the subnet where the Application Gateway should be deployed."
}

variable "frontend_port" {
  description = "Frontend port for the Application Gateway."
  default     = 80
}

variable "publicIP_id" {
  description = "ID of public of the app gateway"
}

variable "env_prefix" {
  description = "Prefix of the env (e.g prd, mgm)."
}


variable "backend_address_pool" {
  description = "List of backend addresses."
  type        = list(string)
}


