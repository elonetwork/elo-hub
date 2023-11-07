terraform {
  backend "azurerm" {
    resource_group_name  = "1-0b50ebfe-playground-sandbox"
    storage_account_name = "tfstatstg"
    container_name       = "tfstate"
    key                  = "terraform.tfstate"
  }
}