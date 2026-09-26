data "azurerm_client_config" "current" {}

resource "azurerm_key_vault" "stage7" {
  name                = "stage7-kv-2026"
  location            = azurerm_resource_group.stage7.location
  resource_group_name = azurerm_resource_group.stage7.name
  tenant_id            = data.azurerm_client_config.current.tenant_id

  sku_name = "standard"

  soft_delete_retention_days = 7
  purge_protection_enabled   = false

  rbac_authorization_enabled = true
}

resource "azurerm_role_assignment" "stage7_vm_keyvault" {
  scope                = azurerm_key_vault.stage7.id
  role_definition_name = "Key Vault Secrets User"
  principal_id         = azurerm_linux_virtual_machine.stage7.identity[0].principal_id
}
