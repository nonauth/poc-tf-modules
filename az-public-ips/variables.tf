// Required input variables
variable environment {
  type        = string
  description = "Resource environment"
}

variable resource_group_name {
  type = string
  description = "Resource group name for virtual network"
}

variable project {
  type        = string
  description = "Project name"
}

variable location {
  type        = string
  description = "Virtual network location"
}

variable ips {
  type = map(object({
    allocation_method = string
    tags              = map(string)
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
