include {
  path = find_in_parent_folders()
}

terraform {
  source = "../../terraform//security"
}

dependencies{
  paths = ["../infrastructure"]
}

dependency "infrastructure" {
  config_path  = "../infrastructure"
}

inputs = {
  sub_firewall_id = dependency.infrastructure.outputs.subnet_firewall_id
  sub_firewall_mgm_id = dependency.infrastructure.outputs.subnet_firewall_mgm_id
  bastion_private_ip = dependency.infrastructure.outputs.bastion_private_ip
  squid_private_ip = dependency.infrastructure.outputs.squid_private_ip
  sub_bastion_id = dependency.infrastructure.outputs.sub_bastion_id
  sub_squid_id = dependency.infrastructure.outputs.sub_squid_id

}
