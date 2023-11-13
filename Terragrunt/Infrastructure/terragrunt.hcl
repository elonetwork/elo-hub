include "root" {
  path = find_in_parent_folders("terragrunt.hcl")
}

terraform{
    source="../../Terraform//Infrastructure/"
}

inputs = {
    name-vnet= "vnet-hub"
    address-space-vnet = [ "10.100.0.0/16" ]
    name-subnet-bastion="BastionSubnet"
    address-prefixes-subnet-bastion=["10.100.1.0/24"]
    name-subnet-firewall="AzureFirewallSubnet"
    address-prefixes-subnet-firewall=["10.100.2.0/24"]
    name-subnet-squid="sub-sequid"
    address-prefixes-subnet-squid=["10.100.3.0/24"]
    name-vm-bastion="vm-bastion"
    name-vm-squid="vm-squid"
    admin-username-vm-bastion="adminuser"
    admin-username-vm-squid="yassine"
    password-vm-squid="OmPassword123"
    vm-size-squid = "Standard_DS1_v2"
    size-vm-bastion="Standard_F2"
    name-network_interface-bastion = "app-interface-bastion"
    filename-key = "~/.ssh/config/linuxkey.pem"
    name-network_interface-squid="app_interface_squid"
    computer-name-squid  = "hostname-squid"
    name-subnet-firewall-mgm="AzureFirewallManagementSubnet"
    address-prefixes-subnet-firewall-mgm=["10.100.4.0/24"]
}