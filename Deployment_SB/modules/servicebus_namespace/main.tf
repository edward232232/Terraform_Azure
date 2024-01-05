variable "key_vault_key_id" {
  description = "The ID of the Key Vault key"
  type        = string
  default = "/subscriptions/1bf989c8-3a84-41ea-9f3a-e1f9ddd22b4a/resourceGroups/myresourcegroup1/providers/Microsoft.KeyVault/vaults/keyvaulttest211131"
}

variable "managed_identity_id" {
  description = "The ID of the Managed Identity"
  type        = string
  default = "/subscriptions/1bf989c8-3a84-41ea-9f3a-e1f9ddd22b4a/resourcegroups/myresourcegroup1/providers/Microsoft.ManagedIdentity/userAssignedIdentities/ekong22"
}

//usiing existing RG
data "azurerm_resource_group" "sb-rg1" {
  name     = "myresourcegroup1"
}


resource "azurerm_servicebus_namespace" "sbns1" {
  name                = "sbns1-sb-namespace"
  location            = data.azurerm_resource_group.sb-rg1.location
  resource_group_name = data.azurerm_resource_group.sb-rg1.name
  sku                 = "Premium"

  customer_managed_key {
    key_vault_key_id  = var.key_vault_key_id
    identity_id       = var.managed_identity_id
    infrastructure_encryption_enabled = true
  }
}