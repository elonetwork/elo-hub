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
    resource_group_name  = "1-47b00d92-playground-sandbox"
    storage_account_name = "hubspokesacount"
    container_name       = "statecontainer"
    key                  = "${path_relative_to_include("hub")}/terraform.tfstate"
  }
}

inputs = {
  location = "eastus"
  resource_group_name = "1-47b00d92-playground-sandbox"
  ssh_public_key = file("C:/Users/MSI/.ssh/id_rsa.pub")
  //ssh_public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQDFRKEm89wkjpMTz3DY02eZpoo6ojzJibqdoxI0cmNS34iETdJzcCVoStg0S79c7FT7XzK4vg5cOJA/0WpZYA8tc1Mjt9CbCDd9ib+MFK58yHIr6+iZpE7+4et6S9NI5jrrde3koStetQxNFpO/atwGJfHfjvc88N07E3BDOL6Ctl4SfXxIGz9cZtmm7XIF85u49pg1xttL1VuoC7AnOH2iVSScTaVSwLGc7ZPdH/EIC/tz+sLeP3rn8kjtfha2kg/nfBtVprFP2V+L+Jtxi3+Q8c4HnTYz3bEX3C14tRtMJYrY86HfFNC6nImQbTnT9s4OVfiLRNXZamUXlEt6gVgO7gb8ssb2MuZqnCNYbS8GF14Z4TDiHTHzuTAE9h8mAeK2/ZKRHAfOhEu/E+y1IY9MwIsvxmZGufmkKZKvj3c9jrzIDC0GxAHB5HMbpuqS2Ke544aHw3b5WVnVee0cY4bYJBXA7NKAKVxBEnLJV9UChabc+ok3zu0JXrw9GceQ+H8ab7JzAZSPKv78BNSLeRQxLtz66aQhSXALPeRoJfHuDVqq9fnvj4A/UWMlocuXspc2sgAawBcKcgOIeAtlduepzQJ5mgDKX1kK7vnEhBqMNpDxrVmZ882vfnZZDS5BqqJJCOr7i5vDmLKhKeos3YTW+u5tZzG6PBM4oeP4G+ZmNQ== msi@DESKTOP-O9IA1B8"

}