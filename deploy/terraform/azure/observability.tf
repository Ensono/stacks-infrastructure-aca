
resource "azurerm_log_analytics_workspace" "la" {
  name                = module.default_label.id
  location            = azurerm_resource_group.default.location
  resource_group_name = azurerm_resource_group.default.name
  sku                 = var.la_sku
  retention_in_days   = var.la_retention
  tags                = module.default_label.tags
}

resource "azurerm_application_insights" "default" {
  count               = var.create_app_insights ? 1 : 0
  name                = module.default_label.id
  resource_group_name = azurerm_resource_group.default.name
  location            = azurerm_resource_group.default.location
  workspace_id        = azurerm_log_analytics_workspace.la.id
  application_type    = var.log_application_type
  depends_on          = [azurerm_resource_group.default]
  lifecycle {
    ignore_changes = [
      tags,
    ]
  }
}
