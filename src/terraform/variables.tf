############################################
# NAMING
############################################

variable "name_company" {
  description = "Company Name - should/will be used in conventional resource naming"
  type        = string
}

variable "name_project" {
  description = "Project Name - should/will be used in conventional resource naming"
  type        = string
}

variable "name_component" {
  description = "Component Name - should/will be used in conventional resource naming. Typically this will be a logical name for this part of the system i.e. `API` || `middleware` or more generic like `Billing`"
  type        = string
}

variable "stage" {
  type = string
}

variable "attributes" {
  description = "Additional attributes for tagging"
  default     = []
}

variable "location" {
  type        = string
  description = "The location of the resource group"
  default     = "uksouth"
}

variable "resource_tags" {
  description = "Map of tags to be applied to all resources"
  type        = map(string)
  default     = {}
}

variable "location_name_map" {
  type = map(string)

  default = {
    northeurope   = "eun"
    westeurope    = "euw"
    uksouth       = "uks"
    ukwest        = "ukw"
    eastus        = "use"
    eastus2       = "use2"
    westus        = "usw"
    eastasia      = "ase"
    southeastasia = "asse"
  }
}

variable "acr_name" {
  type        = string
  description = "Name of ACR"
}

variable "acr_rg" {
  type        = string
  description = "RG of ACR"
}

variable "acae_name" {
  type        = string
  description = "Name of Azure Container App Environment"
}

variable "container_app_workload_profile_name" {
  type        = string
  default     = "Consumption"
  description = "The name of the Workload Profile in the Container App Environment to place this Container App"
}


# Container App
variable "create_rg" {
  type        = bool
  default     = false
  description = "Set value whether to create a Resource group or not."
}

variable "create_container_app_environment" {
  type        = bool
  default     = false
  description = "Set value whether to create a Container App Environment or not."
}

variable "create_container_app" {
  type        = bool
  default     = true
  description = "Set value whether to create Container Apps or not."
}

variable "container_app_name" {
  type        = string
  description = "The name of the Container App"
}

variable "container_app_revision_mode" {
  type        = string
  description = "The revision mode of the Container App. Possible values include `Single` and `Multiple`"
  default     = "Single"
}

variable "container_app_ingress_target_port" {
  type        = number
  default     = 3000
  description = "The target port on the container for the Ingress traffic. "
}

variable "container_app_ingress_external_enabled" {
  type        = bool
  default     = true
  description = " Enable external ingress from outside the Container App Environment."
}

variable "image_name" {
  type        = string
  default     = "satacrtest.azurecr.io/frontendtestapp"
  description = "The name of the image"
}

variable "image_tag" {
  type        = string
  default     = "latest"
  description = "Image tag"
}

variable "container_name" {
  type        = string
  default     = "main-container"
  description = "Container name"
}

variable "container_app_container_max_replicas" {
  type        = number
  default     = 3
  description = "The maximum number of replicas for the containers."
}

variable "container_app_container_min_replicas" {
  type        = number
  default     = 1
  description = "The minimum number of replicas for the containers."
}
