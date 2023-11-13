/* include "root" {
  path = find_in_parent_folders("terragrunt.hcl")
}

terraform{
    source="../../Terraform//Network/"
}

dependencies {
  paths = ["../Infrastructure/"]
}

dependency "subnet-bastion" {
  config_path = "../Infrastructure/"
}

inputs = {
  name-interface="app_interface_bastion"
  resource_group_name ="1-2e696e34-playground-sandbox"
  subnet_id = dependency.subnet-bastion.outputs.subnet-bastion-id
  location ="eastus"
} */