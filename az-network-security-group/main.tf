locals {
  effective_common_tags = merge(var.common_tags, var.tags)
}


resource "azurerm_network_security_group" "this" {
  name                = join("-", [var.project, var.name, var.environment])
  location            = var.location
  resource_group_name = var.resource_group_name
    
  dynamic security_rule {
    for_each = var.security_rules
    iterator = item

    content {
      name                       = item.key
      priority                   = item.value.priority
      direction                  = item.value.direction
      access                     = item.value.access
      protocol                   = item.value.protocol
      source_port_range          = item.value.source_port_range
      destination_port_range     = item.value.destination_port_range
      source_address_prefix      = item.value.source_address_prefix
      destination_address_prefix = item.value.destination_address_prefix
    }
  }

  tags = local.effective_common_tags
}
