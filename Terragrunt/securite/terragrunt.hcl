include "root" {
  path = find_in_parent_folders("terragrunt.hcl")
}

terraform{
    source="../../Terraform//securite/"
}

dependencies {
  paths = ["../../Terragrunt/infrastructure/" ]
}

dependency "infrastructure" {  //export modules outputs
  config_path = "../../Terragrunt/infrastructure/"
}


inputs = {
  subnet_ids = {
    bastion = dependency.infrastructure.outputs.bastion_subnet_id
    squid = dependency.infrastructure.outputs.squid_subnet_id
  }
  bastion_private_ip = dependency.infrastructure.outputs.bastion_private_ip
  sub_firewall_id = dependency.infrastructure.outputs.firewall_subnet_id
  firewall-mgmt_id = dependency.infrastructure.outputs.firewall-mgmt_id
}