generate "provider" {
  path = "provider.tf"
  if_exists = "overwrite_terragrunt"
  contents = <<EOF
 terraform {
 }
provider "azurerm" {
  skip_provider_registration = "true"
    features {}
 }
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
        resource_group_name = "1-e0fb6f93-playground-sandbox"
        storage_account_name = "tfstatstorag"
        container_name = "tfstate"
  }
}
 EOF
} 

remote_state {
    backend = "azurerm"
    config = {
        key = "${path_relative_to_include()}/terraform.tfstate"
        resource_group_name = "1-e0fb6f93-playground-sandbox"
        storage_account_name = "tfstatstorag"
        container_name = "tfstate"
    }
}

inputs= {
     location = "eastus"
     resource_group_name = "1-e0fb6f93-playground-sandbox"
}
