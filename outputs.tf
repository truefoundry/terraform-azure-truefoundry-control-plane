output "truefoundry_db_name" {
  value = var.create_db ? var.database_name : "dummy"
}

output "truefoundry_db_fqdn" {
  value = var.create_db ? resource.azurerm_postgresql_flexible_server.postgresql_flexible[0].fqdn : "dummy"
}

output "truefoundry_db_password" {
  value     = var.create_db ? random_password.truefoundry_db_password.result : "dummy"
  sensitive = true
}

output "truefoundry_db_username" {
  value = var.create_db ? local.truefoundry_db_master_username : "dummy"
}

output "truefoundry_db_port" {
  value = "5432"
}

output "truefoundry_db_subnet_id" {
  value = var.create_db ? azurerm_subnet.postgresql_flexible_subnet[0].id : "dummy"
}

output "truefoundry_storage_container_id" {
  value = var.create_blob_storage ? azurerm_storage_container.truefoundry[0].id : "dummy"
}

output "svcfoundry_identity_client_id" {
  value = azurerm_user_assigned_identity.svcfoundry.client_id
}

output "mlfoundry_identity_client_id" {
  value = azurerm_user_assigned_identity.mlfoundry.client_id
}

output "truefoundry_blob_uri" {
  description = "The primary blob endpoint URI for the storage account"
  value       = var.create_blob_storage ? azurerm_storage_account.this[0].primary_blob_endpoint : ""
}

output "truefoundry_blob_connection_string" {
  description = "The primary connection string for the storage account"
  value       = var.create_blob_storage ? azurerm_storage_account.this[0].primary_connection_string : ""
  sensitive   = true
}
