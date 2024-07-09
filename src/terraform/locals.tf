locals {
  location_short_key = lookup(var.location_name_map, lower(var.location), "unknown")

  container_app_containers = [
    {
      cpu    = 0.25
      image  = "${var.image_name}:${var.image_tag}"
      memory = "0.5Gi"
      name   = var.container_name
      env = [{
        name  = "API_BASE_URL"
        value = "https://backendapp.lemonocean-9d31a840.uksouth.azurecontainerapps.io"
      }]
      volume_mounts = [
        {
          name = "data"
          path = "/app/data"
        }
      ]
    }

  ]

  container_app_container_volumes = [
    {
      name         = "data"
      storage_type = "EmptyDir"
    }
  ]

  container_app_registry = {
    server               = "${var.acr_name}.azurecr.io"
    username             = data.azurerm_container_registry.acr.admin_username
    password_secret_name = "registry-credentials"
  }

  container_app_secrets = [
    {
      name  = "registry-credentials"
      value = data.azurerm_container_registry.acr.admin_password
    }
  ]

  container_app_identity = {
    type = "SystemAssigned"
  }
}
