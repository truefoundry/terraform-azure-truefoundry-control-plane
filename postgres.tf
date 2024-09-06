resource "random_password" "truefoundry_db_password" {
  length           = 24
  special          = true
  override_special = "!#()-_=+[]:?"
}

resource "azurerm_subnet" "postgresql_flexible_subnet" {
  count                = var.create_db ? 1 : 0
  name                 = replace("${var.unique_name}-postgres", "-", "")
  resource_group_name  = var.resource_group_name
  virtual_network_name = var.truefoundry_db_vnet_name
  address_prefixes     = [var.truefoundry_db_subnet_cidr]
  service_endpoints    = ["Microsoft.Sql"]
  delegation {
    name = "fs"
    service_delegation {
      name = "Microsoft.DBforPostgreSQL/flexibleServers"
      actions = [
        "Microsoft.Network/virtualNetworks/subnets/join/action",
      ]
    }
  }
}

resource "azurerm_postgresql_flexible_server" "postgresql_flexible" {
  count               = var.create_db ? 1 : 0
  name                = var.truefoundry_db_enable_override ? var.truefoundry_db_override_name : "${var.unique_name}-psql"
  resource_group_name = var.resource_group_name
  location            = var.location
  version             = var.postgres_version
  authentication {
    password_auth_enabled = true
  }
  administrator_login    = local.truefoundry_db_master_username
  administrator_password = random_password.truefoundry_db_password.result
  delegated_subnet_id    = azurerm_subnet.postgresql_flexible_subnet[0].id
  private_dns_zone_id    = var.truefoundry_db_private_dns_zone_id
  zone                   = "3"
  high_availability {
    mode                      = "SameZone"
    standby_availability_zone = "3"
  }
  backup_retention_days = 14
  storage_mb            = var.truefoundry_db_allocated_storage
  sku_name              = var.truefoundry_db_instance_class
  tags                  = local.tags
}

resource "azurerm_postgresql_flexible_server_database" "postgresql_flexible_database" {
  count     = var.create_db ? 1 : 0
  name      = var.database_name
  server_id = azurerm_postgresql_flexible_server.postgresql_flexible[0].id
  collation = "en_US.utf8"
  charset   = "utf8"
}
resource "azurerm_postgresql_flexible_server_configuration" "postgres_flexible_configuration" {
  count     = var.create_db ? 1 : 0
  name      = "require_secure_transport"
  server_id = azurerm_postgresql_flexible_server.postgresql_flexible[0].id
  value     = var.truefoundry_db_require_ssl ? "ON" : "OFF"
}

resource "azurerm_postgresql_flexible_server_firewall_rule" "postgres_flexible_firewall_rule" {
  count            = var.create_db ? 1 : 0
  name             = "postgres-flexible-firewall-rule"
  server_id        = azurerm_postgresql_flexible_server.postgresql_flexible[0].id
  start_ip_address = var.truefoundry_db_allowed_ip_range_start_ip_address
  end_ip_address   = var.truefoundry_db_allowed_ip_range_end_ip_address
}
