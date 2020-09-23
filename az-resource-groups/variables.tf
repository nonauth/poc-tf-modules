// Required input variables
variable environment {
  type        = string
  description = "Resource environment"
}

variable resource_groups {
  type = map(object({
    location = string
    tags     = map(string)
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
