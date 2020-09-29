locals {
  effective_common_tags = merge(var.common_tags, var.tags)
}

data "azurerm_key_vault_secret" "this" {
  for_each = var.vms

  name         = each.value.secret_name
  key_vault_id = each.value.key_vault_id
}

resource "azurerm_network_interface" "this" {
  for_each = var.vms

  name                        = join("-", [var.project, each.key, var.environment])
  location                    = var.location
  resource_group_name         = var.resource_group_name

  dynamic ip_configuration {
    for_each = each.value.public_ip_address_id == "" ? [1] : []

    content {
      name                          = "NicConfiguration"
      subnet_id                     = each.value.subnet_id
      private_ip_address_allocation = each.value.private_ip_address_allocation
    }
  }

  dynamic ip_configuration {
    for_each = each.value.public_ip_address_id != "" ? [1] : []

    content {
      name                          = "NicConfiguration"
      subnet_id                     = each.value.subnet_id
      private_ip_address_allocation = each.value.private_ip_address_allocation
      public_ip_address_id          = each.value.public_ip_address_id
    }
  }

  tags = merge(local.effective_common_tags, each.value.tags)
}

resource "azurerm_network_interface_security_group_association" "this" {
  for_each = var.vms

  network_interface_id      = azurerm_network_interface.this[each.key].id
  network_security_group_id = each.value.network_security_group_id
}

resource "azurerm_linux_virtual_machine" "this" {

  for_each = var.vms
  name                  = join("-", [var.project, each.key, var.environment])
  location              = var.location
  resource_group_name   = var.resource_group_name
  network_interface_ids = [azurerm_network_interface.this[each.key].id]
  size                  = each.value.size

  os_disk {
    name                 = "OsDisk"
    caching              = "ReadWrite"
    storage_account_type = "Premium_LRS"
  }

  source_image_reference {
    publisher = each.value.image.publisher
    offer     = each.value.image.offer
    sku       = each.value.image.sku
    version   = each.value.image.version
  }

  computer_name  = join("-", [var.project, each.key, var.environment])
  admin_username = each.value.admin_username
  disable_password_authentication = true
        
  admin_ssh_key {
    username       = each.value.admin_username
    public_key     = data.azurerm_key_vault_secret.this[each.key].value
  }

  boot_diagnostics {
    storage_account_uri = each.value.storage_account_uri
  }

  tags = merge(local.effective_common_tags, each.value.tags)
}
