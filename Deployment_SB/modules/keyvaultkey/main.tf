variable "key_vault_key_id" {
  description = "The ID of the Key Vault key"
  type        = string
  default = "/subscriptions/1bf989c8-3a84-41ea-9f3a-e1f9ddd22b4a/resourceGroups/myresourcegroup1/providers/Microsoft.KeyVault/vaults/keyvaulttest211131"
}



variable "key_vault_id" {
  description = "The ID of the Key Vault"
  type        = string
  default = "https://keyvaulttest211131.vault.azure.net/keys/sbkey1/2db7a63c5c8946b4bd14b814e9b16715"
}



resource "azurerm_key_vault_key" "kv_key" {
 name         = "mykey"  // replace with your desired key name
  key_vault_id = var.key_vault_id  // replace with your Key Vault ID
  key_type     = "RSA"
  key_opts     = ["decrypt", "encrypt", "sign", "unwrapKey", "verify", "wrapKey"]
}

output "keyvault_key_id" {
  value = azurerm_key_vault_key.kv_key.id
}