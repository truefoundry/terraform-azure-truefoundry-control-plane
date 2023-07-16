resource "random_password" "truefoundry_db_password" {
  length           = 24
  special          = true
  override_special = "!#$%&*()-_=+[]{}<>:?"
}

module "postgresql-db" {
  count                            = var.create_db == true ? 1 : 0
  source                           = "Azure/postgresql/azurerm"
  version                          = "3.1.1"
  server_name                      = var.truefoundry_db_enable_override ? var.truefoundry_db_override_name : "${var.unique_name}-db"
  sku_name                         = var.truefoundry_db_instance_class
  location                         = var.location
  resource_group_name              = var.resource_group_name
  storage_mb                       = var.truefoundry_db_allocated_storage
  backup_retention_days            = 7
  geo_redundant_backup_enabled     = false
  administrator_login              = local.truefoundry_db_master_username
  administrator_password           = random_password.truefoundry_db_password.result
  server_version                   = "11"
  ssl_enforcement_enabled          = false
  ssl_minimal_tls_version_enforced = "TLSEnforcementDisabled"
  db_names                         = [var.database_name]
  tags                             = local.tags
  public_network_access_enabled    = false
}

resource "azurerm_private_endpoint" "postgresql_private_connection" {
  count               = var.create_db == true ? 1 : 0
  name                = "${var.unique_name}-db-private-endpoint"
  location            = var.location
  resource_group_name = var.resource_group_name
  subnet_id           = var.truefoundry_db_subnet_id

  private_service_connection {
    name                           = "${var.unique_name}-db-private-connection"
    private_connection_resource_id = module.postgresql-db[0].server_id
    is_manual_connection           = false
    subresource_names              = ["postgresqlServer"]
  }
}
