
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
  source = "git::https://github.com/Ensono/terraform-azurerm-aca?ref=1.0.3"

  resource_group_name                                      = azurerm_resource_group.default.name
  location                                                 = azurerm_resource_group.default.location
  container_app_environment_name                           = module.default_label.id
  log_analytics_workspace_id                               = azurerm_log_analytics_workspace.la.id
  workload_profiles                                        = var.workload_profiles
  create_container_app_environment                         = true
  create_container_app                                     = false
  create_rg                                                = var.create_rg
  container_app_environment_internal_load_balancer_enabled = true
  container_app_environment_infrastructure_subnet_id       = var.create_aca_vnet ? azurerm_subnet.aca[0].id : null
}
