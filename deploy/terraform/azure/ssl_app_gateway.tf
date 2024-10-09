/*
module "ssl_app_gateway" {
  source = "git::https://github.com/Ensono/stacks-terraform//azurerm/modules/azurerm-app-gateway?ref=v4.0.6"

  resource_namer            = module.default_label.id
  resource_group_name       = azurerm_resource_group.default.name
  resource_group_location   = azurerm_resource_group.default.location
  dns_resource_group        = var.dns_resource_group
  vnet_name                 = var.create_acavnet ? azurerm_virtual_network.default[0].name : data.azurerm_virtual_network.default[0].name 
  vnet_cidr                 = var.vnet_cidr
  dns_zone                  = var.dns_zone
  #pfx_password              = var.pfx_password
  aks_resource_group        = azurerm_resource_group.default.name
  aks_ingress_ip            = "51.142.218.161" #this is the backend ip#var.is_cluster_private ? module.aks_bootstrap.aks_ingress_private_ip : module.aks_bootstrap.aks_ingress_public_ip
  subnet_front_end_prefix   = cidrsubnet(var.vnet_cidr.0, 4, 3)
  subnet_backend_end_prefix = cidrsubnet(var.vnet_cidr.0, 4, 4)
  subnet_names              = ["aca"]
  acme_email                = ""
  create_valid_cert         = false

  ssl_policy = {
    "policy_type" = "Predefined",
    "policy_name" = "AppGwSslPolicy20170401S",
  }
}
*/
