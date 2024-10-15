data "azurerm_virtual_network" "default" {
  count               = var.create_aca_vnet ? 0 : 1
  name                = var.vnet_name
  resource_group_name = var.vnet_resource_group
}


# NETWORK
resource "azurerm_virtual_network" "default" {
  count               = var.create_aca_vnet ? 1 : 0
  name                = var.vnet_name != "" ? var.vnet_name : module.default_label.id
  resource_group_name = azurerm_resource_group.default.name
  address_space       = var.vnet_cidr
  location            = azurerm_resource_group.default.location
  depends_on          = [azurerm_resource_group.default]
  lifecycle {
    ignore_changes = [
      tags,
    ]
  }
}

resource "azurerm_subnet" "aca" {
  count               = var.create_aca_vnet ? 1 : 0
  name                = "aca"
  resource_group_name = azurerm_resource_group.default.name
  # this can stay referencing above as they get created or not together
  virtual_network_name = azurerm_virtual_network.default.0.name
  address_prefixes     = [cidrsubnet(var.vnet_cidr.0, 4, 0)]
  depends_on           = [azurerm_virtual_network.default]

  delegation {
    name = "delegation"
    service_delegation {
      name    = "Microsoft.App/environments"
      actions = ["Microsoft.Network/virtualNetworks/subnets/join/action"]
    }
  }
}

