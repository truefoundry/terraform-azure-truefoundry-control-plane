resource "azurerm_role_assignment" "mlfoundry" {
  count                = var.create_blob_storage == true ? 1 : 0
  scope                = azurerm_storage_container.truefoundry[0].resource_manager_id
  role_definition_name = "Storage Blob Data Contributor"
  principal_id         = azurerm_user_assigned_identity.mlfoundry.principal_id
}
