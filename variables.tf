variable "resourcegroup-name" {
  type    = string
  default = "1-0b50ebfe-playground-sandbox"
}

variable "location" {
  type    = string
  default = "eastus"
}

variable "subnets_hub" {
  type = map(any)
  default = {
    subnet_1 = {
      name            = "BastionSubnet"
      adress_prefixes = ["10.100.1.0/24"]
    }
    subnet_2 = {
      name            = "AzureFirewallSubnet"
      adress_prefixes = ["10.100.2.0/24"]
    }
    subnet_3 = {
      name            = "sub-sequid"
      adress_prefixes = ["10.100.3.0/24"]
    }
  }
}

/* variable "subnets_hub_nsg" {
  type = map(any)
  default = {
    subnet_1 = {
      name            = "BastionSubnet"
      adress_prefixes = ["10.100.1.0/24"]
    }
    subnet_3 = {
      name            = "sub-sequid"
      adress_prefixes = ["10.100.3.0/24"]
    }
  }
} */
