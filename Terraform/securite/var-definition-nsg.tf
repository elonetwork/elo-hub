variable "nsg_names" {
  description = "Names for the network security groups"
  
  default     = {
    sub_bastion = "nsg-sub-bastion"
    sub_squid   = "nsg-sub-squid"
  }  # Replace with your default values
}
