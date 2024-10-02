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

variable "name_environment" {
  type = string
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


# Log Analytics workspace Details

variable "la_sku" {
  type        = string
  default     = "PerGB2018"
  description = "Specifies the SKU of the Log Analytics Workspace."
}

variable "la_retention" {
  type        = number
  default     = 30
  description = "The workspace data retention in days. Possible values are either 7 (Free Tier only) or range between 30 and 730."
}

variable "create_rg" {
  type        = bool
  default     = false
  description = "Set value whether to create a Resource group using ACA module or not."
}

variable "create_container_app_environment" {
  type        = bool
  default     = true
  description = "Set value whether to create a Container App Environment or not."
}

variable "create_container_app" {
  type        = bool
  default     = false
  description = "Set value whether to create Container Apps or not."
}

variable "workload_profiles" {
  type = list(object({
    name                  = string
    workload_profile_type = string
    maximum_count         = number
    minimum_count         = number
  }))
  default = [
    {
      name                  = "Consumption"
      workload_profile_type = "Consumption"
      maximum_count         = 1
      minimum_count         = 1
    },
    {
      name                  = "Standard"
      workload_profile_type = "D4"
      maximum_count         = 3
      minimum_count         = 1
    }
  ]
  description = "List of workload profiles to be created in the Container App Environment. Workload profile type for the workloads to run on. Possible values include `Consumption`, `D4`, `D8`, `D16`, `D32`, `E4`, `E8`, `E16` and `E32`."

}
