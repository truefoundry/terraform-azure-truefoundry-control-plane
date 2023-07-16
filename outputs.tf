output "truefoundry_db_name" {
  value = var.create_db == true ? var.database_name : "dummy"
}

output "truefoundry_db_endpoint" {
  value = var.create_db == true ? module.postgresql-db[0].server_fqdn : "dummy"
}

output "truefoundry_db_private_ip" {
  value = var.create_db == true ? resource.azurerm_private_endpoint.postgresql_private_connection[0].private_service_connection[0].private_ip_address : "dummy"
}

output "truefoundry_db_password" {
  value     = var.create_db == true ? module.postgresql-db[0].administrator_password : "dummy"
  sensitive = true
}

output "truefoundry_db_port" {
  value = "5432"
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