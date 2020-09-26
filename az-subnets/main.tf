resource "azurerm_subnet" "this" {
  for_each = var.subnets

  name                 = join("-", [var.project, each.key, var.environment])
  resource_group_name  = each.value.resource_group_name
  virtual_network_name = each.value.virtual_network_name
  address_prefixes     = each.value.address_prefixes
}
