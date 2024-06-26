
# Naming convention
module "default_label" {
  source     = "git::https://github.com/cloudposse/terraform-null-label.git?ref=0.24.1"
  namespace  = format("%s-%s", var.name_company, var.name_project)
  stage      = var.stage
  name       = "${lookup(var.location_name_map, var.location)}-${var.name_component}"
  attributes = var.attributes
  delimiter  = "-"
  tags       = var.resource_tags
}


module "aca" {
  source = "git::https://github.com/Ensono/terraform-azurerm-aca?ref=feature/7427-terraform-module-for-aca"

  resource_group_name = module.default_label.id
  location            = var.location
  resource_tags       = module.default_label.tags

  create_container_app_environment = var.create_container_app_environment
  create_container_app             = var.create_container_app
  create_rg                        = var.create_rg

  # Container App
  container_app_name                  = var.container_app_name
  container_app_registry              = local.container_app_registry
  container_app_secrets               = local.container_app_secrets
  container_app_identity              = local.container_app_identity
  container_app_environment_id        = data.azurerm_container_app_environment.acae.id
  container_app_workload_profile_name = var.container_app_workload_profile_name
  container_app_revision_mode         = var.container_app_revision_mode

  # Container App Container
  container_app_containers             = local.container_app_containers
  container_app_container_max_replicas = var.container_app_container_max_replicas
  container_app_container_min_replicas = var.container_app_container_min_replicas
  container_app_container_volumes      = local.container_app_container_volumes

  #  Ingress configuration
  container_app_ingress_external_enabled = var.container_app_ingress_external_enabled
  container_app_ingress_target_port      = var.container_app_ingress_target_port

}
