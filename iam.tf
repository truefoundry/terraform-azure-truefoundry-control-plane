resource "azurerm_user_assigned_identity" "svcfoundry" {
  location            = var.location
  name                = local.svcfoundry_unique_name
  resource_group_name = var.resource_group_name
}

# https://azure.github.io/azure-workload-identity/docs/quick-start.html
resource "azurerm_federated_identity_credential" "svcfoundry" {
  name                = local.svcfoundry_unique_name
  resource_group_name = var.resource_group_name
  audience            = ["api://AzureADTokenExchange"]
  issuer              = var.cluster_oidc_url
  parent_id           = azurerm_user_assigned_identity.svcfoundry.id
  subject             = "system:serviceaccount:${var.svcfoundry_namespace}:${var.svcfoundry_svc_acc}"
}

resource "azurerm_user_assigned_identity" "mlfoundry" {
  location            = var.location
  name                = local.mlfoundry_unique_name
  resource_group_name = var.resource_group_name
}

resource "azurerm_federated_identity_credential" "mlfoundry" {
  name                = local.mlfoundry_unique_name
  resource_group_name = var.resource_group_name
  audience            = ["api://AzureADTokenExchange"]
  issuer              = var.cluster_oidc_url
  parent_id           = azurerm_user_assigned_identity.mlfoundry.id
  subject             = "system:serviceaccount:${var.mlfoundry_namespace}:${var.mlfoundry_svc_acc}"
}
