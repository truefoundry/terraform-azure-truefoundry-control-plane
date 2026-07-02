# INFRA-902: truefoundry_blob_uri must include the container segment.
#
# primary_blob_endpoint is computed, so we mock the providers. The azurerm
# provider validates several computed IDs as real Azure resource IDs at plan
# time (role_assignment scope, federated_identity parent_id), so mock_resource
# blocks supply valid-format IDs for those types. The container name is
# config-derived (local.truefoundry_unique_name from cluster_name = "mycluster"),
# so the expected URI is fully known. Two runs prove the trimsuffix guard handles
# the endpoint both with and without a trailing slash.

mock_provider "random" {}

mock_provider "azurerm" {
  mock_resource "azurerm_user_assigned_identity" {
    defaults = {
      id           = "/subscriptions/00000000-0000-0000-0000-000000000000/resourceGroups/rg-test/providers/Microsoft.ManagedIdentity/userAssignedIdentities/uai"
      principal_id = "00000000-0000-0000-0000-000000000000"
      client_id    = "00000000-0000-0000-0000-000000000000"
    }
  }

  mock_resource "azurerm_storage_container" {
    defaults = {
      resource_manager_id = "/subscriptions/00000000-0000-0000-0000-000000000000/resourceGroups/rg-test/providers/Microsoft.Storage/storageAccounts/acct/blobServices/default/containers/mycluster"
    }
  }
}

variables {
  resource_group_name                              = "rg-test"
  cluster_name                                     = "mycluster"
  location                                         = "eastus"
  cluster_oidc_url                                 = "https://oidc.example/abc"
  truefoundry_db_vnet_name                         = "vnet-test"
  truefoundry_db_subnet_cidr                       = "10.0.20.0/28"
  truefoundry_db_private_dns_zone_id               = "/subscriptions/x/zones/y"
  truefoundry_db_allowed_ip_range_start_ip_address = "10.0.0.1"
  truefoundry_db_allowed_ip_range_end_ip_address   = "10.0.0.254"
  create_db                                        = false
  create_acr                                       = false
  create_kv                                        = false
  create_blob_storage                              = true
}

run "endpoint_with_trailing_slash" {
  command = plan

  override_resource {
    target = azurerm_storage_account.this
    values = {
      primary_blob_endpoint = "https://acct.blob.core.windows.net/"
    }
  }

  assert {
    condition     = output.truefoundry_blob_uri == "https://acct.blob.core.windows.net/mycluster"
    error_message = "blob_uri must append the container with a single slash when endpoint has a trailing slash"
  }
}

run "endpoint_without_trailing_slash" {
  command = plan

  override_resource {
    target = azurerm_storage_account.this
    values = {
      primary_blob_endpoint = "https://acct.blob.core.windows.net"
    }
  }

  assert {
    condition     = output.truefoundry_blob_uri == "https://acct.blob.core.windows.net/mycluster"
    error_message = "blob_uri must append the container with a single slash when endpoint has no trailing slash"
  }
}
