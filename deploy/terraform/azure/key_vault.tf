##################################################
##  AKS SPN
##################################################
# KEY VAULT
resource "azurerm_key_vault" "default" {
  count                       = var.create_key_vault ? 1 : 0
  name                        = var.key_vault_name != "" ? var.key_vault_name : substr(module.default_label.id, 0, 24)
  location                    = azurerm_resource_group.default.location
  resource_group_name         = azurerm_resource_group.default.name
  enabled_for_disk_encryption = true
  # current RG owner tenant ID
  tenant_id = data.azurerm_client_config.current.tenant_id
  # soft_delete_enabled         = true
  # purge_protection_enabled    = false

  sku_name = "standard"

  access_policy {
    tenant_id = data.azurerm_client_config.current.tenant_id
    object_id = data.azurerm_client_config.current.object_id

    key_permissions = [
      "Get",
    ]

    secret_permissions = [
      "Get",
    ]

    storage_permissions = [
      "Get",
    ]
  }

  network_acls {
    default_action = "Deny"
    bypass         = "AzureServices"
  }

  depends_on = [
    azurerm_resource_group.default
  ]
  lifecycle {
    ignore_changes = [
      tags,
    ]
  }
}
