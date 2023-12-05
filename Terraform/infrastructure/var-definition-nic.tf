variable "bastion_nic_name" {
  description = "The name of the bastion network interface"
  default     = "bastion-nic"  
}

variable "squid_nic_name" {
  description = "The name of the network interface for Squid VM"
  default     = "squid-nic"
}


variable "squid_ip_configuration_name" {
  default = "squid_ip_configuration"
}