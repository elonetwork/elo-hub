variable "squid_route_name" {
  description = "The name of the route for Squid"
  default     = "squid-route"
}

variable "squid_subnet_association_name" {
  description = "The name of the association for Squid subnet"
  default     = "squid-subnet-association"
}

variable "internet_route_name" {
  description = "Name for the internet route"
  default     = "route-http"
}

variable "subnet_ids" {
  description = "Map of subnet IDs"
  type        = map(string)
  /*default = {
    bastion = ""
    squid   = ""
  }*/
}


variable "firewall_private_ip_address" {
  
}