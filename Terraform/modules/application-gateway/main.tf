
resource "azurerm_public_ip" "app_gateway_public_ip" {
  name                = join("_", [var.var.env_prefix, "app_gateway_public_ip"])
  resource_group_name = var.resource_group_name
  location            = var.location
  allocation_method   = "Dynamic"
}


resource "azurerm_application_gateway" "app_gateway" {
  name                = var.app_gateway_name
  resource_group_name = var.resource_group_name
  location            = var.location
  sku {
    name     = "WAF_v2"
    tier     = "WAF_v2"
    capacity = 2
  }

  backend_http_settings {
    name                  = join("_", [var.var.env_prefix, "app_gateway_http_settings"])
    cookie_based_affinity = "Disabled"
    port                  = 80
    protocol              = "Http"
    request_timeout       = 30
    probe_name            = "example_probe"
  }


  gateway_ip_configuration {
    name      = "example-configuration"
    subnet_id = var.subnet_id
  }

  frontend_port {
    name = join("_", [var.var.env_prefix, "app_gateway_frontend-port"])
    port = var.frontend_port
  }

  frontend_ip_configuration {
    name                 = join("_", [var.var.env_prefix, "app_gateway_frontend_ip_configuration"])
    public_ip_address_id = azurerm_public_ip.app_gateway_public_ip.id
  }

  backend_address_pool {
    name = join("_", [var.var.env_prefix, "app_gateway_backend_address_pool"])
  }

  http_listener {
    name                           = "example-http-listener"
    protocol                       = 80
    frontend_ip_configuration_name = join("_", [var.var.env_prefix, "app_gateway_frontend_ip_configuration"])
    frontend_port_name             = join("_", [var.var.env_prefix, "app_gateway-frontend-port"])
  }

  request_routing_rule {
    name                       = "example-routing-rule"
    rule_type                  = "Basic"
    http_listener_name         = azurerm_application_gateway.example.http_listener[0].name
    backend_address_pool_name  = azurerm_application_gateway.example.backend_address_pool[0].name
    backend_http_settings_name = azurerm_application_gateway.example.http_settings[0].name
  }


}

