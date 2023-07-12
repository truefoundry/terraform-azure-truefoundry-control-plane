resource "azurerm_storage_account" "this" {
  count = var.create_blob_storage == true ? 1 : 0
  name                     = replace(local.truefoundry_unique_name, "-", "")
  resource_group_name      = var.resource_group_name
  location                 = var.location
  account_tier             = "Standard"
  account_replication_type = "LRS"

  tags = local.tags
}

resource "azurerm_storage_container" "truefoundry" {
  count = var.create_blob_storage == true ? 1 : 0
  name                  = local.truefoundry_unique_name
  storage_account_name  = azurerm_storage_account.this[0].name
  container_access_type = "blob"
}
