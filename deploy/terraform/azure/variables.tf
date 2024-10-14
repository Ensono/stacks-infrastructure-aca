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

###########################
# ACR SETTINGS
###########################
variable "create_acr" {
  description = "whether to create a ACR"
  type        = bool

  default = false
}

variable "acr_resource_group" {
  description = "Supply your own resource group name for ACR"
  type        = string

  default = ""
}

variable "acr_name" {
  description = "ACR name"
  type        = string

  default = ""
}

variable "registry_admin_enabled" {
  description = "Whether ACR admin is enabled"
  type        = bool

  default = true
}

variable "registry_sku" {
  description = "ACR SKU"
  type        = string

  default = "Standard"
}


###########################
# MISC SETTINGS
###########################

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

variable "create_app_insights" {
  description = "Specify if a app insights should be created"
  type        = bool

  default = false
}
variable "log_application_type" {
  description = "Log application type"
  type        = string

  default = "other"
}

variable "key_vault_name" {
  description = "Key Vault name - if not specificied will default to computed naming convention"
  type        = string

  default = ""
}

variable "create_key_vault" {
  description = "Specify if a key vault should be created"
  type        = bool

  default = false
}

#########################################
# DNS
#########################################
variable "dns_zone" {
  description = "Dns zone name - e.g. nonprod.domain.com, you should avoid using an APEX zone"
  type        = string

  default = ""
}

variable "dns_resource_group" {
  type        = string
  description = "RG that contains the existing DNS zones, if the zones are not being created here"

  default = null
}

###########################
# VNET 
###########################
variable "create_acavnet" {
  description = "whether to create a vnet"
  type        = bool

  default = false
}

variable "vnet_resource_group" {
  description = "Supply your own resource group name for vnet"
  type        = string

  default = ""
}

variable "vnet_name" {
  description = "vnet name"
  type        = string

  default = ""
}

variable "vnet_cidr" {
  description = "CIDR block notation for VNET"
  type        = list(string)
  default     = ["11.1.0.0/16"]
}

variable "subnet_prefixes" {
  description = "Prefix for subnet - should be in the form of x.x.x.x/x"
  type        = list(string)

  default = [""]
}

variable "subnet_names" {
  description = "Names for subnets"
  type        = list(string)

  default = [""]
}

variable "acme_email" {
  type        = string
  description = "Email for Acme registration, must be a valid email"
}

variable "pfx_password" {
  type = string
}
