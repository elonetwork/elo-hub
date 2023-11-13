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

dependency "app-interface-bastion" {
  config_path = "../Infrastructure/"
}

inputs = {
  name-sequid= "nsg-sequid"
  name-bastion="nsg-bastion"
  location="eastus"
  resource_group_name ="1-e0fb6f93-playground-sandbox"
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
  nat_rule_collection-name="nat_rule_collection"
  nat_rule_collection-priority=100
  nat_rule_collection-action="Dnat"
  nat_rule_collection-rule-name="rule-tcp"
  nat_rule_collection-rule-source-addresses=["*"]
  nat_rule_collection-rule-destination_ports=["22"]
  nat_rule_collection-rule-translated_port=22
  nat_rule_collection-rule-translated_address=dependency.app-interface-bastion.outputs.app-interface-bastion-private_ip_address
  nat_rule_collection-rule-protocols=["TCP"]
  firewall_network_rule_collection-name="firewall_allow_traffic_network_collection"
  firewall_network_rule_collection-priority=100
  firewall_network_rule_collection-action="Allow"
  firewall_network_rule_collection-rule-name="allow_http_https_dns"
  firewall_network_rule_collection-rule-source_addresses=["*"]
  firewall_network_rule_collection-rule-destination_ports=["53","80","443"]
  firewall_network_rule_collection-rule-destination_addresses=["*"]
  firewall_network_rule_collection-rule-protocols=["TCP","UDP"]
  protocole-http="80"
  protocole-https="443"
  priority-110=110
  priority-200=200
  name-nsg-http-allow-outbound-squid="nsg-http-allow-outbound-squid"
  name-nsg-https-allow-outbound-squid="nsg-https-allow-outbound-squid"
  name-nsg-deny-all-outbound-squid="nsg-deny-all-outbound-squid"
}