// Required input variables
variable environment {
  type        = string
  description = "Resource environment"
}

variable resource_group_name {
  type = string
  description = "Resource group name"
}

variable location {
  type        = string
  description = "Storage account location"
}

variable storage_accounts {
  type = map(object({
    azurerm_storage_account = string
    account_tier            = string
    tags                    = map(string)
  }))
}

variable project {
  type        = string
  description = "Project name"
}

// Optional input variables
variable common_tags {
  type        = map(string)
  default     = {}
  description = "Common tags for all resources"
}

variable tags {
  type        = map(string)
  default     = {}
  description = "Special tags from tg file"
}
