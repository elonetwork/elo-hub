include {
  path = find_in_parent_folders()
}

terraform {
  source = "../../terraform//network"
}

dependencies{
  paths = ["../infrastructure","../security"]
}

dependency "infrastructure" {
  config_path  = "../infrastructure"
}

dependency "security" {
  config_path  = "../security"
}

inputs = {
  firewall_private_ip = dependency.security.outputs.firewall_private_ip
  sub_squid_id = dependency.infrastructure.outputs.sub_squid_id
  vnet_hub_id = dependency.infrastructure.outputs.vnet_hub_id
  vnet_hub_name = dependency.infrastructure.outputs.vnet_hub_name

  squid-vm-route-table_name = "squid-vm-route-table"
  squid_route_name = "route_squid_to_firewall"
  squid_route_address_prefix = "0.0.0.0/0"
  squid_route_next_hop_type = "VirtualAppliance"

}
