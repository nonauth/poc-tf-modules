// Required input variables
variable environment {
  type        = string
  description = "Resource environment"
}

variable project {
  type        = string
  description = "Project name"
}

variable subnets {
  type = map(object({
    resource_group_name  = string
    virtual_network_name = string
    address_prefixes     = list(string)
  }))
}
