output vault {
  value = azurerm_key_vault.this
}

output secrets {
  value = azurerm_key_vault_secret.this
}
