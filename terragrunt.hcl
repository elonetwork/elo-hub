
remote_state {
  backend = "azurerm"
  generate = {
    path      = "backend.tf"
    if_exists = "overwrite_terragrunt"
  }
  config = {
    key                  = "${path_relative_to_include()}/terraform.tfstate"
    resource_group_name  = "1-4ad89eca-playground-sandbox"
    storage_account_name = "storeelonetwork"
    container_name       = "containerst"
    subscription_id       = "2213e8b1-dbc7-4d54-8aff-b5e315df5e5b"
    tenant_id            = "84f1e4ea-8554-43e1-8709-f0b8589ea118"
    snapshot             = true
  }
}

locals {
  provider_config = {
    features = {}
    skip_provider_registration = true
      client_id       = "062614a4-3057-402c-ad4f-8c086bdb0b48"
  client_secret   = "eGJ8Q~MALNVG0OObcGxUBsAhPTv02ghKtKtRrblA"
  subscription_id = "2213e8b1-dbc7-4d54-8aff-b5e315df5e5b"
  tenant_id       = "84f1e4ea-8554-43e1-8709-f0b8589ea118"
  }
}
