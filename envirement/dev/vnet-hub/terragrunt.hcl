include {
  path = find_in_parent_folders()
}
terraform {
  source = "../../../vnet-hub/"  
}

# dependencies {
#   paths = ["../../../vnet-hub/modules/network", "../../../vnet-hub/modules/security"]
# }

inputs = {
  # resource_group_name = var.resource_group_name
  location = "West us"
}

# dependency "" {
#   config_path = "../"
# }

