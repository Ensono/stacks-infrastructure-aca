module "ssl_app_gateway" {
  source = "git::https://github.com/Ensono/stacks-terraform//azurerm/modules/azurerm-app-gateway?ref=6.0.24"

  resource_namer            = module.default_label.id
  resource_group_name       = azurerm_resource_group.default.name
  resource_group_location   = azurerm_resource_group.default.location
  dns_resource_group        = var.dns_resource_group
  vnet_name                 = var.create_aca_vnet ? azurerm_virtual_network.default[0].name : data.azurerm_virtual_network.default[0].name
  vnet_cidr                 = var.vnet_cidr
  dns_zone                  = var.dns_zone
  pfx_password              = var.pfx_password
  aks_resource_group        = azurerm_resource_group.default.name
  aks_ingress_ip            = module.acae.static_ip_address
  subnet_front_end_prefix   = cidrsubnet(var.vnet_cidr.0, 4, 3)
  subnet_backend_end_prefix = cidrsubnet(var.vnet_cidr.0, 4, 4)
  subnet_names              = ["aca"]
  acme_email                = var.acme_email
  create_valid_cert         = true
  probe_path                = "/"
  # We need to set the status code here to 404 because we are using custom domains in the ACA in order for the requests to be routed correctly.
  expected_status_codes = ["404"]
  ssl_policy = {
    "policy_type" = "Predefined",
    "policy_name" = "AppGwSslPolicy20170401S",
  }
}
