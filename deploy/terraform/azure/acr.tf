resource "azurerm_container_registry" "registry" {
  count               = var.create_acr ? 1 : 0
  name                = var.acr_registry_name != "" ? replace(var.acr_registry_name, "-", "") : replace(module.default_label.id, "-", "")
  resource_group_name = azurerm_resource_group.default.name
  location            = azurerm_resource_group.default.location
  admin_enabled       = var.registry_admin_enabled
  sku                 = var.registry_sku

  lifecycle {
    ignore_changes = [
      tags,
    ]
  }
}
