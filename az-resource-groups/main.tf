locals {
  effective_common_tags = merge(var.common_tags, var.tags)
}

resource "azurerm_resource_group" "this" {
  for_each = var.resource_groups

  name     = join("-", [var.project, each.key, var.environment])
  location = each.value.location

  tags = merge(local.effective_common_tags, each.value.tags)
}
