module "ssl_app_gateway" {
  source = "git::https://github.com/Ensono/stacks-terraform//azurerm/modules/azurerm-app-gateway?ref=add-app-gateway-sku-variables"

  resource_namer                            = module.default_label.id
  resource_group_name                       = azurerm_resource_group.default.name
  resource_group_location                   = azurerm_resource_group.default.location
  dns_resource_group                        = var.dns_resource_group
  vnet_name                                 = var.create_acavnet ? azurerm_virtual_network.default[0].name : data.azurerm_virtual_network.default[0].name
  vnet_cidr                                 = var.vnet_cidr
  dns_zone                                  = var.dns_zone
  pfx_password                              = var.pfx_password
  aks_resource_group                        = azurerm_resource_group.default.name
  aks_ingress_ip                            = module.acae.static_ip_address
  subnet_front_end_prefix                   = cidrsubnet(var.vnet_cidr.0, 4, 3)
  subnet_backend_end_prefix                 = cidrsubnet(var.vnet_cidr.0, 4, 4)
  subnet_names                              = ["aca"]
  acme_email                                = var.acme_email
  create_valid_cert                         = true
  pick_host_name_from_backend_http_settings = true
  host_name                                 = "aca.${var.dns_zone}"
  ssl_policy = {
    "policy_type" = "Predefined",
    "policy_name" = "AppGwSslPolicy20170401S",
  }
}
