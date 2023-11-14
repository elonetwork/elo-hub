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
  firewall_sku_name = "AZFW_VNet"
  firewall_sku_tier = "Basic"
  firewall_ip_configuration_name = "configuration"
  firewall_management_ip_configuration_name = "management"
  nsg_sub_bastion_name = "nsg-sub-bastion"
  nsg_sub_squid_name = "nsg_sub_squid"
  nsr_in_ssh_vm_bastion_name = "nsr_ssh_vm_bastion"
  nsr_out_ssh_vm_bastion_name = "nsr_out_ssh_vm_bastion"
  nsr_in_ssh_vm_squid_name = "nsr_in_ssh_vm_squid"
  nsr_out_web_vm_squid = "nsr_out_web_vm_squid"
  nsr_out_web_vm_bastion = "nsr_out_web_vm_bastion"
}
