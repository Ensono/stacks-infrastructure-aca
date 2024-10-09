output "resource_group_name" {
  value = azurerm_resource_group.default.name
}

output "acae_name" {
  value = module.acae.container_app_environment_name
}

output "acae_id" {
  value = module.acae.container_app_environment_id
}

#########################################
# ACR
#########################################
# If the ACR was created by this deployment then return its name otherwise return the ACR name that has been created by a different deployment
output "acr_registry_name" {
  description = "Created ACR name"
  value       = var.create_acr ? azurerm_container_registry.registry.0.name : var.acr_registry_name
  depends_on  = [azurerm_resource_group.default]
}

output "acr_resource_group_name" {
  description = "Created ACR resource group Name"
  value       = var.create_acr ? azurerm_container_registry.registry.0.resource_group_name : var.acr_resource_group
  depends_on  = [azurerm_resource_group.default]
}

#########################################
# Key Vault
#########################################
# If the Key Vault was created by this deployment then return its name otherwise return the Key Vault name that has been created by a different deployment
output "key_vault_name" {
  value = var.create_key_vault ? azurerm_key_vault.default.0.name : var.key_vault_name
}

#########################################
# Application Insights
#########################################

output "app_insights_resource_group_name" {
  value = var.create_app_insights ? azurerm_application_insights.default[0].resource_group_name : null
}

output "app_insights_name" {
  value = var.create_app_insights ? azurerm_application_insights.default[0].name : null
}

output "app_insights_id" {
  value = var.create_app_insights ? azurerm_application_insights.default[0].id : null
}

output "instrumentation_key" {
  value     = var.create_app_insights ? azurerm_application_insights.default[0].instrumentation_key : null
  sensitive = true
}

#########################################
# Log Analytics
#########################################

output "log_analytics_resource_group_name" {
  value = azurerm_log_analytics_workspace.la.resource_group_name
}
output "log_analytics_name" {
  value = azurerm_log_analytics_workspace.la.name
}

output "log_analytics_id" {
  value = azurerm_log_analytics_workspace.la.id
}

output "log_analytics_key" {
  value     = azurerm_log_analytics_workspace.la.primary_shared_key
  sensitive = true
}
