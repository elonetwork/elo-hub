# variable "subnets" {
#   description = "List of subnets"
#   type        = list(object({
#     name                = string
#     address_prefixes    = list(string)
#   }))
# }

variable "name" {
  
}

variable "address_prefixes" {
  
}

variable "network_name" {
  description = "name of the Virtual Network"
}

variable "resource_group_name" {
  description = "Name of the Resource Group"
}