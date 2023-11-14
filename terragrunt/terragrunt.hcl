generate "provider" {
  path      = "provider.tf"
  if_exists = "overwrite_terragrunt"
  contents  = <<EOF
provider "azurerm" {
  features {}
    skip_provider_registration = true

}
EOF
}

remote_state {
  backend = "azurerm"
  generate = {
    path      = "backend.tf"
    if_exists = "overwrite"
  }
  config = {
    resource_group_name  = "1-1284a985-playground-sandbox"
    storage_account_name = "storageaccountguru3"
    container_name       = "hubcontainer"
    key                  = "${path_relative_to_include("hub")}/terraform.tfstate"
  }
}

inputs = {
  location = "southcentralus"
  resource_group_name = "1-1284a985-playground-sandbox"
  ssh_public_key = file("C:/Users/LENOVO/.ssh/id_rsa.pub")
  //ssh_public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQDp3L/8xh1hQwutlnbkJPlOkM3JtMXQGZZH/UBZYB7zOLM0VXXcRCxEI2VbZZ9Iv9clU051qi2AMeWuSUoT7pHGJ4v5y8CZVygPtCGRLYNyxkExHa2CrSEas8DDelKq3LAteuBmZTQWM9MhFHpOtAIxI27FScoZ+XX3Cv7q+RlHM+1QJukvU42SaFxM737dVhYo9Y3xUxkB9gXHpwZPB/ujAVSggwQ2Cv65GJxTZcOpF8GEc7yFVU1mrEO8nThvV/vU9n7UfO7svbETjDu84dxYx4d6egfkJJEluy3K6wELzZAzSBL5r3B0H8V91NKiHVHYzFckfBkWMu0AoEytUzH8en57eH7nVr2mIbhSHEV6dkhjXsHDiTSbB/GW985WygO5cDkxys6TxDf38AWmLFOlHt3iNYwiN0xFxvPBpWrjUPyn4QJ6oNr8vcamsHMC+uWgPMHTJjl4BHjHw8mToxVpqLF18umdQI93lWTTLtgz5ItruQUDwviABwnuQ43EhLkLzUqlBJhjIPNlH/PveAU5gE7nTxvDrLOcXNQISL9vBBL3o6fnaL3IZ18peFR1YQncI75njAzl55kBCQA0GevAcO4XTTQckinPgle2eEG0DSzKlg1kS2igMXQDKCIghLM0B+cUQaiJOEQ2j+XZfCJciYLuqdTG57z86kPZKrVs6w== saijiro"

}