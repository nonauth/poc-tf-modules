locals {
  effective_common_tags = merge(var.common_tags, var.tags)
}


data "azurerm_client_config" "current" {}


resource "azurerm_key_vault" "this" {
  name                = join("-", [var.project, var.name, var.environment])
  location            = var.location
  resource_group_name = var.resource_group_name
  tenant_id           = data.azurerm_client_config.current.tenant_id

  sku_name = var.sku_name

  access_policy {
    tenant_id = data.azurerm_client_config.current.tenant_id
    object_id = data.azurerm_client_config.current.object_id

    key_permissions = [
      "create",
      "get",
      "list",
    ]

    secret_permissions = [
      "set",
      "get",
      "delete",
      "list",
    ]
  }

  tags = local.effective_common_tags
}

resource "azurerm_key_vault_secret" "this" {
  for_each = var.public_keys

  name         = join("-", [var.project, each.key, var.environment])
  value        = each.value.key
  key_vault_id = azurerm_key_vault.this.id

  tags = merge(local.effective_common_tags, each.value.tags)
}
