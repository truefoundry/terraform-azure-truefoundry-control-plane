
################################################################################
# Common
################################################################################

variable "resource_group_name" {
  description = "Name of the resource group"
  type        = string
}

variable "cluster_name" {
  description = "Cluster name"
  type        = string
  validation {
    condition     = length(var.cluster_name) <= 24 || length(var.cluster_name) >= 3
    error_message = "Error: 3 <= len(cluster_name) <= 24"
  }
}

variable "location" {
  description = "Location of the resource group"
  type        = string
}

variable "tags" {
  type        = map(string)
  default     = {}
  description = "AWS Tags common to all the resources created"
}

variable "cluster_oidc_url" {
  description = "OIDC url for the cluster to create federated credential for"
  type        = string
}

################################################################################
# Database
################################################################################

variable "create_db" {
  type        = bool
  description = "Create postgres flexible server database or not"
  default     = true
}

variable "postgres_version" {
  default     = "13"
  description = "PostgreSQL version"
  type        = string
}

variable "database_name" {
  type        = string
  description = "Name of the database in postgres"
  default     = "truefoundry"
}

variable "truefoundry_db_enable_override" {
  type        = bool
  description = "Truefoundry db name override to be enabled"
  default     = false
}

variable "truefoundry_db_override_name" {
  type        = string
  description = "Truefoundry db name override"
  default     = ""
}

variable "truefoundry_db_instance_class" {
  type        = string
  description = "Instance class for DB"
  default     = "GP_Standard_D4ds_v5"
}

variable "truefoundry_db_allocated_storage" {
  type        = number
  description = "Storage for DB"
  default     = 32768
}

variable "truefoundry_db_require_ssl" {
  type        = bool
  description = "Require SSL for DB"
  default     = false
}

variable "truefoundry_db_vnet_name" {
  description = "Name of the virtual network"
  type        = string
}

variable "truefoundry_db_subnet_cidr" {
  type        = string
  description = "CIDR of the subnet which we should use for the db"
}

variable "truefoundry_db_private_dns_zone_id" {
  type        = string
  description = "Private DNS zone ID"
}

variable "truefoundry_db_allowed_ip_range_start_ip_address" {
  type        = string
  description = "IP range start address which is allowed to connect to DB"
}

variable "truefoundry_db_allowed_ip_range_end_ip_address" {
  type        = string
  description = "IP range end address which is allowed to connect to DB"
}

################################################################################
# Container Registry
################################################################################

variable "create_acr" {
  type        = bool
  description = "Create acr"
  default     = false
}

################################################################################
# Key vault
################################################################################

variable "create_kv" {
  type        = bool
  description = "Create kv"
  default     = false
}

################################################################################
# Storage account
################################################################################

variable "create_blob_storage" {
  type        = bool
  description = "Create blob storage"
  default     = false
}

################################################################################
# Mlfoundry-server
################################################################################

variable "mlfoundry_svc_acc" {
  description = "Name of the mlfoundry service account"
  default     = "mlfoundry-server"
  type        = string
}

variable "mlfoundry_namespace" {
  description = "Name of the mlfoundry namespace"
  default     = "truefoundry"
  type        = string
}

################################################################################
# Servicefoundry-server
################################################################################

variable "svcfoundry_svc_acc" {
  description = "Name of the svcfoundry service account"
  default     = "servicefoundry-server"
  type        = string
}

variable "svcfoundry_namespace" {
  description = "Name of the svcfoundry namespace"
  default     = "truefoundry"
  type        = string
}
