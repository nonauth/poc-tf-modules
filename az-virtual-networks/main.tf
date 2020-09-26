locals {
  effective_common_tags = merge(var.common_tags, var.tags)
}


resource "azurerm_virtual_network" "this" {
  for_each = var.virtual_networks

  name                = join("-", [var.project, each.key, var.environment])
  address_space       = each.value.address_space
  location            = each.value.location
  resource_group_name = var.resource_group_name

  tags = merge(local.effective_common_tags, each.value.tags)
}
