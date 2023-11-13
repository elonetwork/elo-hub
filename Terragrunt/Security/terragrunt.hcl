include "root" {
  path = find_in_parent_folders("terragrunt.hcl")
}

terraform{
    source="../../Terraform//Securite/"
}

dependencies {
  paths = ["../Infrastructure/"]
}

dependency "subnet-bastion" {
  config_path = "../Infrastructure/"
}

dependency "subnet-squid" {
  config_path = "../Infrastructure/"
}

dependency "subnet-firwall" {
  config_path = "../Infrastructure/"
}

dependency "subnet-firwall-mgm" {
  config_path = "../Infrastructure/"
}

inputs = {
  name-sequid= "nsg-sequid"
  name-bastion="nsg-bastion"
  location="eastus"
  resource_group_name ="1-2e696e34-playground-sandbox"
  subnet-bastion=dependency.subnet-bastion.outputs.subnet-bastion-id
  subnet-sequid=dependency.subnet-squid.outputs.subnet-squid-id
  access-deny="Deny"
  access-allow="Allow"
  direction-inbound="Inbound"
  direction-outbound="Outbound"
  priority-1000=1000
  priority-100=100
  value-etoile="*"
  name-deny-all-inbound-rule-bastion="deny-all-inbound-rule-bastion"
  name-allow-tcp-outbound-rule-bastion="allow-tcp-outbound-rule-bastion"
  name-allow-tcp-inbound-rule-bastion="allow-tcp-inbound-rule-bastion"
  name-deny-all-inbound-rule-squid="deny-all-inbound-rule-squid"
  name-allow-tcp-inbound-rule-squid="allow-tcp-inbound-rule-squid"
  port22="22"
  protocole-tcp="Tcp"
  name-firewall="firewall"
  sku_name="AZFW_VNet"
  sku_tier="Basic"
  name_ip_configuration="configuration"
  subnet_id=dependency.subnet-firwall.outputs.subnet-firewall-id
  name_ip_management="management"
  subnet_id_management=dependency.subnet-firwall-mgm.outputs.subnet-firwall-mgm-id

}