output "rg_name" {
  value = azurerm_resource_group.default.name
}

output "acae_name" {
  value = module.acae.container_app_environment_name
}

output "acae_id" {
  value = module.acae.container_app_environment_id
}

# output "acr_name" {
#   value = azurerm_container_registry.acr.name
# }

# output "acr_id" {
#   value = azurerm_container_registry.acr.id
# }
