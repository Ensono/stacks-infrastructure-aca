
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

module "default_label_short" {
  source              = "git::https://github.com/cloudposse/terraform-null-label.git?ref=0.24.1"
  namespace           = format("%s-%s", substr(var.name_company, 0, 4), substr(var.name_project, 0, 4))
  stage               = var.stage
  name                = "${lookup(var.location_name_map, var.location)}-${substr(var.name_component, 0, 6)}"
  attributes          = var.attributes
  delimiter           = ""
  tags                = var.resource_tags
  id_length_limit     = 20
  regex_replace_chars = "/[^a-zA-Z0-9]/"
}

resource "azurerm_resource_group" "default" {
  name     = module.default_label.id
  location = var.location
  tags     = module.default_label.tags
}

module "acae" {
  source = "git::https://github.com/Ensono/terraform-azurerm-aca?ref=1.0.2"

  resource_group_name                                      = azurerm_resource_group.default.name
  location                                                 = azurerm_resource_group.default.location
  container_app_environment_name                           = module.default_label.id
  log_analytics_workspace_id                               = azurerm_log_analytics_workspace.la.id
  workload_profiles                                        = var.workload_profiles
  create_container_app_environment                         = true
  create_container_app                                     = true
  create_rg                                                = var.create_rg
  container_app_environment_internal_load_balancer_enabled = true
  container_app_environment_infrastructure_subnet_id       = var.create_acavnet ? azurerm_subnet.aca[0].id : null

  # Container App
  container_app_name = "nginx"
  container_app_registry = {
    server   = "${var.acr_name}.azurecr.io"
    identity = azurerm_user_assigned_identity.default.id
  }
  container_app_identity = {
    type         = "UserAssigned",
    identity_ids = [azurerm_user_assigned_identity.default.id]
  }

  container_app_workload_profile_name = "Consumption"
  container_app_revision_mode         = "Single"

  # Container App Container
  container_app_containers = [
    {
      cpu    = 0.25
      image  = "nginx:latest"
      memory = "0.5Gi"
      name   = "nginx"
      # env = [{
      #   name  = "API_BASE_URL"
      #   value = "https://backendapp.lemonocean-9d31a840.uksouth.azurecontainerapps.io"
      # }]
      volume_mounts = [
        # {
        #   name = "data"
        #   path = "/app/data"
        # }
      ]
    }

  ]
  container_app_container_max_replicas = 1
  container_app_container_min_replicas = 1
  # container_app_container_volumes      = [
  #   {
  #     name         = "data"
  #     storage_type = "EmptyDir"
  #   }
  # ]

  #  Ingress configuration
  container_app_ingress_external_enabled           = true
  container_app_ingress_target_port                = 80
  container_app_ingress_allow_insecure_connections = true
}

resource "azurerm_container_app_custom_domain" "app" {
  name                     = "aca.${var.dns_zone}"
  container_app_id         = module.acae.container_app_id
  certificate_binding_type = "Disabled"
}
