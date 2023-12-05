generate "provider" {
  path = "provider.tf"
  if_exists = "overwrite_terragrunt"
  contents = <<EOF
provider "azurerm" {
  skip_provider_registration = "true"
    features {}
 }
 EOF
}

generate "export_script" {
  path = "export_tenant_id.sh"
  if_exists = "overwrite_terragrunt"
  contents = <<EOF
    #!/bin/bash

    echo "exporting tenant id"
    #export TF_VAR_tenant_id=$(az account show --query tenantId --output tsv)

 EOF
}

# Backend 
generate "backend" {
  path = "backend.tf"
  if_exists = "overwrite_terragrunt"
  contents = <<EOF
terraform {
  backend "azurerm" {
        key = "${path_relative_to_include()}/terraform.tfstate"
        resource_group_name = "1-af5835bd-playground-sandbox"
        storage_account_name = "pseudo0021"
        container_name = "hub"
  }
}
 EOF
} 
terraform {
  before_hook "before_hook_1" {
    commands = ["apply", "plan"]
    execute  = ["echo", "Will run Terraform"]
  }

  before_hook "set_tenant_id_env_var_hook" {
    commands = ["apply", "plan"]
    execute  = ["bash", "-c", "source export_tenant_id.sh"]
  }
}

remote_state {
    backend = "azurerm"
    config = {
        key = "${path_relative_to_include()}/terraform.tfstate"
        resource_group_name = "1-af5835bd-playground-sandbox"
        storage_account_name = "pseudo0021"
        container_name = "hub"
    }
}

inputs= {
    location = "eastus"
    resource_group_name = "1-af5835bd-playground-sandbox"
    storage_account_name = "pseudo0021"
    aks_service_principal= {
      client_id     = "052da770-3489-41c9-8f73-8e1af4f204d3"
      client_secret = "CQf8Q~NeBx~M2Mns.la0nymdmvpJzRV5cdLwcaJV"
    } 
  
}
