terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "2.92.0"
    }
  }
}

provider "azurerm" {
  skip_provider_registration = true
  subscription_id = "2213e8b1-dbc7-4d54-8aff-b5e315df5e5b"
  client_id       = "9b6ec07f-7c3a-45e4-b737-0b117b2eb520"
  client_secret   = "75X8Q~Krwr2WYgDDEGxO-FaTEZbQijnPx59SpbyI"
  tenant_id       = "84f1e4ea-8554-43e1-8709-f0b8589ea118"
  features {}
}