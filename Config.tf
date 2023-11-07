terraform {
  backend "azurerm" {
    resource_group_name  = "1-7859974b-playground-sandbox"
    storage_account_name = "psdme0998"
    container_name       = "myftconteneur"
    key                  = "terraform.tfstate"
  }
}

provider "azurerm" {
  features {}
  skip_provider_registration = true
}

resource "azurerm_resource_group" "my_rg" {
  name     = "1-7859974b-playground-sandbox"
  location = "westus"
}




