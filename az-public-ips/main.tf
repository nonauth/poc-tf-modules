locals {
  effective_common_tags = merge(var.common_tags, var.tags)
}


resource "azurerm_public_ip" "this" {
    for_each = var.ips

    name                = join("-", [var.project, each.key, var.environment])
    location            = var.location
    resource_group_name = var.resource_group_name
    allocation_method   = each.value.allocation_method

    tags = merge(local.effective_common_tags, each.value.tags)
}
