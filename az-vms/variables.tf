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

variable vms {
  type = map(object({
    subnet_id                     = string
    private_ip_address_allocation = string
    public_ip_address_id          = string
    network_security_group_id     = string
    size                          = string
    image                         = map(string)
    os_disk                       = map(string)
    admin_username                = string
    secret_name                   = string
    key_vault_id                  = string
    storage_account_uri           = string
    tags                          = map(string)
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
