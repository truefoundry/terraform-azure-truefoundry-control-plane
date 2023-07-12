resource "azurerm_container_registry" "svcfoundry" {
  count               = var.create_acr == true ? 1 : 0
  name                = local.svcfoundry_unique_name
  resource_group_name = var.resource_group_name
  location            = var.location
  sku                 = "Standard"
}