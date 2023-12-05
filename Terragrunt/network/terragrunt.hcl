include "root" {
  path = find_in_parent_folders("terragrunt.hcl")
}

terraform{
    source="../../Terraform//network/"
}
dependencies {
  paths = ["../../Terragrunt/securite" ]
}

dependency "infrastructure" {
  config_path = "../../Terragrunt/infrastructure"
}

dependency "securite" {
  config_path = "../../Terragrunt/securite"
}
inputs = {
 subnet_ids = {
    bastion = dependency.infrastructure.outputs.bastion_subnet_id
    squid = dependency.infrastructure.outputs.squid_subnet_id
 }
 firewall_private_ip_address = dependency.securite.outputs.firewall_private_ip_address
}