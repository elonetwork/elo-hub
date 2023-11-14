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
}
