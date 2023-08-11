resource "azurerm_storage_account" "this" {
  count                    = var.create_blob_storage ? 1 : 0
  name                     = replace(local.truefoundry_unique_name, "-", "")
  resource_group_name      = var.resource_group_name
  location                 = var.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
  blob_properties {
    cors_rule {
      allowed_headers    = ["*"]
      allowed_methods    = ["GET", "POST", "PUT"]
      allowed_origins    = ["*"]
      exposed_headers    = ["Etag"]
      max_age_in_seconds = 3000
    }
  }

  tags = local.tags
}

resource "azurerm_storage_container" "truefoundry" {
  count                 = var.create_blob_storage ? 1 : 0
  name                  = local.truefoundry_unique_name
  storage_account_name  = azurerm_storage_account.this[0].name
  container_access_type = "blob"
}
