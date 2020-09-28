locals {
  effective_common_tags = merge(var.common_tags, var.tags)
}

resource "random_string" "this" {
  for_each = var.storage_accounts

  length  = 24
  upper   = false
  lower   = true
  number  = false
  special = false
}

resource "azurerm_storage_account" "this" {
  for_each = var.storage_accounts

  name                        = random_string.this[each.key].result
  resource_group_name         = var.resource_group_name
  location                    = var.location
  account_replication_type    = each.value.azurerm_storage_account
  account_tier                = each.value.account_tier

  tags = merge(local.effective_common_tags, each.value.tags)

  depends_on = [
    random_string.this,
  ]
}
