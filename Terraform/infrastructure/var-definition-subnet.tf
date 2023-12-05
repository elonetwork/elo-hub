variable "address_prefixes" {
  description = "The address prefix for the subnets"
  default     = {
    azure_firewall     = "10.0.1.0/24"
    sub_bastion        = "10.0.2.0/24"
    sub_squid          = "10.0.3.0/24"
    firewall_management = "10.0.4.0/24"
  }  # Replace with your default values
}
variable "subnet_names" {
  description = "Names for the subnets"
  default     = {
    azure_firewall     = "AzureFirewallSubnet"
    sub_bastion        = "sub-bastion"
    sub_squid          = "sub-squid"
    firewall_management = "AzureFirewallManagementSubnet"
  }  # Replace with your default values
}