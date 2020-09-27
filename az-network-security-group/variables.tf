// Required input variables
variable environment {
  type        = string
  description = "Resource environment"
}

variable resource_group_name {
  type = string
  description = "Resource group name"
}

variable project {
  type        = string
  description = "Project name"
}

variable name {
  type        = string
  description = "Main part of sg name"
}

variable location {
  type        = string
  description = "Virtual network location"
}

variable security_rules {
  type = map(object({
    priority                   = string
    direction                  = string
    access                     = string
    protocol                   = string
    source_port_range          = string
    destination_port_range     = string
    source_address_prefix      = string
    destination_address_prefix = string
  }))
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
