resource "azurerm_user_assigned_identity" "default" {
  resource_group_name = module.default_label.id
  location            = var.location
  name                = module.default_label.id
  lifecycle {
    ignore_changes = [
      tags,
    ]
  }
}

resource "azurerm_role_assignment" "acrpull_role" {
  scope                            = var.create_acr ? azurerm_container_registry.registry[0].id : data.azurerm_container_registry.acr[0].id
  role_definition_name             = "AcrPull"
  principal_id                     = azurerm_user_assigned_identity.default.principal_id
  skip_service_principal_aad_check = true
}
