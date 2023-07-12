resource "azurerm_role_assignment" "storage_svcfoundry" {
  count                = var.create_blob_storage == true ? 1 : 0
  scope                = azurerm_storage_container.truefoundry[0].resource_manager_id
  role_definition_name = "Storage Blob Data Contributor"
  principal_id         = azurerm_user_assigned_identity.svcfoundry.principal_id
}

resource "azurerm_role_assignment" "acr_svcfoundry" {
  count                = var.create_acr == true ? 1 : 0
  scope                = azurerm_container_registry.svcfoundry[0].id
  role_definition_name = "Contributor"
  principal_id         = azurerm_user_assigned_identity.svcfoundry.principal_id
}
