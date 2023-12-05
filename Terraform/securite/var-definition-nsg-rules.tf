variable "nsg_rule_priorities" {
  description = "Priorities for network security rules"
  default = {
    allow_ssh          = 101
    allow_http         = 100
    allow_outbound_tls = 110
    deny_outbound      = 200
    deny_inbound       = 200
  }  # Modify with your priority values
}




variable "subnet_ids" {
  description = "Map of subnet IDs"
  type        = map(string)
}

variable "subnet_nsg_association_names" {
  description = "Map of subnet network security group association names"
  type        = map(string)
  default = {
    bastion = "bastion_nsg_association"
    squid   = "squid_nsg_association"
    # Add more association names if needed
  }
}