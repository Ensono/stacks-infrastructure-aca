data "azurerm_client_config" "current" {}

data "azurerm_container_registry" "acr" {
  name                = var.acr_name
  resource_group_name =  module.default_label.id #"aca-test-rg"
}

data "azurerm_container_app_environment" "acae" {
  name                = var.acae_name
  resource_group_name = module.default_label.id
}
