# terraform-azure-truefoundry-control-plane
Truefoundry Azure Control Plane Module

<!-- BEGIN_TF_DOCS -->
## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| <a name="provider_azurerm"></a> [azurerm](#provider\_azurerm) | n/a |
| <a name="provider_random"></a> [random](#provider\_random) | n/a |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_postgresql-db"></a> [postgresql-db](#module\_postgresql-db) | Azure/postgresql/azurerm | 3.1.1 |

## Resources

| Name | Type |
|------|------|
| [azurerm_container_registry.svcfoundry](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/container_registry) | resource |
| [azurerm_federated_identity_credential.mlfoundry](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/federated_identity_credential) | resource |
| [azurerm_federated_identity_credential.svcfoundry](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/federated_identity_credential) | resource |
| [azurerm_key_vault.akv_svcfoundry](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/key_vault) | resource |
| [azurerm_private_endpoint.postgresql_private_connection](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/private_endpoint) | resource |
| [azurerm_role_assignment.acr_svcfoundry](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/role_assignment) | resource |
| [azurerm_role_assignment.mlfoundry](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/role_assignment) | resource |
| [azurerm_role_assignment.storage_svcfoundry](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/role_assignment) | resource |
| [azurerm_storage_account.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/storage_account) | resource |
| [azurerm_storage_container.truefoundry](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/storage_container) | resource |
| [azurerm_user_assigned_identity.mlfoundry](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/user_assigned_identity) | resource |
| [azurerm_user_assigned_identity.svcfoundry](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/user_assigned_identity) | resource |
| [random_password.truefoundry_db_password](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/password) | resource |
| [azurerm_client_config.current](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/client_config) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_cluster_oidc_url"></a> [cluster\_oidc\_url](#input\_cluster\_oidc\_url) | OIDC url for the cluster to create federated credential for | `string` | n/a | yes |
| <a name="input_create_acr"></a> [create\_acr](#input\_create\_acr) | Create acr | `bool` | `false` | no |
| <a name="input_create_blob_storage"></a> [create\_blob\_storage](#input\_create\_blob\_storage) | Create blob storage | `bool` | `false` | no |
| <a name="input_create_db"></a> [create\_db](#input\_create\_db) | Create db | `bool` | `false` | no |
| <a name="input_create_kv"></a> [create\_kv](#input\_create\_kv) | Create kv | `bool` | `false` | no |
| <a name="input_database_name"></a> [database\_name](#input\_database\_name) | name of the database in postgres | `string` | `"truefoundry"` | no |
| <a name="input_location"></a> [location](#input\_location) | Location of the resource group | `string` | n/a | yes |
| <a name="input_mlfoundry_namespace"></a> [mlfoundry\_namespace](#input\_mlfoundry\_namespace) | Name of the mlfoundry namespace | `string` | `"truefoundry"` | no |
| <a name="input_mlfoundry_svc_acc"></a> [mlfoundry\_svc\_acc](#input\_mlfoundry\_svc\_acc) | Name of the mlfoundry service account | `string` | `"mlfoundry-server"` | no |
| <a name="input_resource_group_name"></a> [resource\_group\_name](#input\_resource\_group\_name) | Name of the resource group | `string` | n/a | yes |
| <a name="input_svcfoundry_namespace"></a> [svcfoundry\_namespace](#input\_svcfoundry\_namespace) | Name of the svcfoundry namespace | `string` | `"truefoundry"` | no |
| <a name="input_svcfoundry_svc_acc"></a> [svcfoundry\_svc\_acc](#input\_svcfoundry\_svc\_acc) | Name of the svcfoundry service account | `string` | `"servicefoundry-server"` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | AWS Tags common to all the resources created | `map(string)` | `{}` | no |
| <a name="input_truefoundry_db_allocated_storage"></a> [truefoundry\_db\_allocated\_storage](#input\_truefoundry\_db\_allocated\_storage) | Storage for DB | `string` | n/a | yes |
| <a name="input_truefoundry_db_enable_override"></a> [truefoundry\_db\_enable\_override](#input\_truefoundry\_db\_enable\_override) | Truefoundry db name override to be enabled | `bool` | `false` | no |
| <a name="input_truefoundry_db_instance_class"></a> [truefoundry\_db\_instance\_class](#input\_truefoundry\_db\_instance\_class) | Instance class for DB | `string` | n/a | yes |
| <a name="input_truefoundry_db_override_name"></a> [truefoundry\_db\_override\_name](#input\_truefoundry\_db\_override\_name) | Truefoundry db name override | `string` | n/a | yes |
| <a name="input_truefoundry_db_subnet_id"></a> [truefoundry\_db\_subnet\_id](#input\_truefoundry\_db\_subnet\_id) | ID of the subnet which the db should use | `string` | n/a | yes |
| <a name="input_unique_name"></a> [unique\_name](#input\_unique\_name) | Truefoundry deployment unique name | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_mlfoundry_identity_client_id"></a> [mlfoundry\_identity\_client\_id](#output\_mlfoundry\_identity\_client\_id) | n/a |
| <a name="output_svcfoundry_identity_client_id"></a> [svcfoundry\_identity\_client\_id](#output\_svcfoundry\_identity\_client\_id) | n/a |
| <a name="output_truefoundry_db_endpoint"></a> [truefoundry\_db\_endpoint](#output\_truefoundry\_db\_endpoint) | n/a |
| <a name="output_truefoundry_db_name"></a> [truefoundry\_db\_name](#output\_truefoundry\_db\_name) | n/a |
| <a name="output_truefoundry_db_password"></a> [truefoundry\_db\_password](#output\_truefoundry\_db\_password) | n/a |
| <a name="output_truefoundry_db_port"></a> [truefoundry\_db\_port](#output\_truefoundry\_db\_port) | n/a |
| <a name="output_truefoundry_db_private_ip"></a> [truefoundry\_db\_private\_ip](#output\_truefoundry\_db\_private\_ip) | n/a |
| <a name="output_truefoundry_storage_container_id"></a> [truefoundry\_storage\_container\_id](#output\_truefoundry\_storage\_container\_id) | n/a |
<!-- END_TF_DOCS -->