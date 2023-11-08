provider "azurerm" {
  features {}
  skip_provider_registration = true
}

terraform {
  backend "azurerm" {
    resource_group_name  = "1-d00b0ff7-playground-sandbox"
    storage_account_name = "storageaccountelo"
    container_name       = "terracontelo"
    key                  = "terraform.tfstate"
  }
}
