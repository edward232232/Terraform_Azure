provider "azurerm" {
  features {}
}

resource "azurerm_servicebus_namespace" "azurermtest" {
  name                          = "azurermtest"
  location                      = "West Europe"
  resource_group_name           = "123"
  sku                           = "Premium"
  capacity                      = 1
  public_network_access_enabled = false

customer_managed_key {
    key_vault_key_id                  = "https://keyvaulttest211131.vault.azure.net/keys/sbkey1/2db7a63c5c8946b4bd14b814e9b16715"
    infrastructure_encryption_enabled = true
    identity_id                       = azurerm_servicebus_namespace.azurermtest.identity[0].principal_id
}

}