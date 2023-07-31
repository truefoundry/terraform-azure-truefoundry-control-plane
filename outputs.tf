output "truefoundry_db_name" {
  value = var.create_db == true ? var.database_name : "dummy"
}

output "truefoundry_db_fqdn" {
  value = var.create_db == true ? resource.azurerm_postgresql_flexible_server.postgresql_flexible[0].fqdn : "dummy"
}

output "truefoundry_db_password" {
  value     = var.create_db == true ? random_password.truefoundry_db_password.result : "dummy"
  sensitive = true
}

output "truefoundry_db_username" {
  value = var.create_db == true ? local.truefoundry_db_master_username : "dummy"
}

output "truefoundry_db_port" {
  value = "5432"
}

output "truefoundry_db_subnet_id" {
  value = var.create_db == true ? azurerm_subnet.postgresql_flexible_subnet[0].id : "dummy"
}

output "truefoundry_storage_container_id" {
  value = var.create_blob_storage == true ? azurerm_storage_container.truefoundry[0].id : "dummy"
}

output "svcfoundry_identity_client_id" {
  value = azurerm_user_assigned_identity.svcfoundry.client_id
}

output "mlfoundry_identity_client_id" {
  value = azurerm_user_assigned_identity.mlfoundry.client_id
}