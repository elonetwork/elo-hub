provider "azurerm" {
  features {}
  skip_provider_registration = true
  client_id                  = "0ce3c066-040c-4366-9f34-01005b8c9247"
  client_secret              = "iG88Q~i6DyfCl5cLZeAWyKlBTM3hT-B8mQz7iagf"
  subscription_id            = "0cfe2870-d256-4119-b0a3-16293ac11bdc" #  Azure subscription ID
  tenant_id                  = "84f1e4ea-8554-43e1-8709-f0b8589ea118" #  Azure tenant ID
}

terraform {
  required_version = ">= 0.12"

  backend "azurerm" {
    resource_group_name  = "1-62e49a50-playground-sandbox"
    storage_account_name = "storeelonetwork"
    container_name       = "containerst"
    key                  = "state.tfstate"
  }
}
