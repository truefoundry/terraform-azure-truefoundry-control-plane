variable "name" {
  description = "name of the project"
  type = string
}
variable "unique_name" {
  description = "Truefoundry deployment unique name"
  type        = string
  validation {
    condition     = length(var.unique_name) <= 24
    error_message = "Error: Unique name is too long."
  }
  validation {
    condition     = length(var.unique_name) >= 3
    error_message = "Error: Unique name is too short."
  }
}

variable "resource_group_name" {
  description = "Name of the resource group"
  type        = string
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

##### Control Plane Components 

#### Database

variable "create_db" {
  type        = bool
  description = "Create db"
  default     = false
}

variable "postgres_version" {
  default = "13"
  description = "PostgreSQL version"
  type = string
}

variable "database_name" {
  type = string
  description = "name of the database in postgres"
  default = "truefoundry"
}

variable "truefoundry_db_enable_override" {
  type        = bool
  description = "Truefoundry db name override to be enabled"
  default     = false
}

variable "truefoundry_db_override_name" {
  type        = string
  description = "Truefoundry db name override"
}

variable "truefoundry_db_instance_class" {
  type        = string
  description = "Instance class for DB"
}

variable "truefoundry_db_allocated_storage" {
  type        = number
  description = "Storage for DB"
}

variable "truefoundry_db_private_dns_zone_id" {
  description = "Private DNS zone ID"
  type = string
}

#### Network
variable "truefoundry_control_plane_subnet_id" {
  type        = string
  description = "id of the subnet which where our control plane is hosted"
}

variable "truefoundry_db_vnet_name" {
  description = "name of the virtual network"
  type = string
}

variable "truefoundry_db_subnet_cidr" {
  type        = string
  description = "CIDR of the subnet which we should use for the db"
}

variable "truefoundry_db_allowed_ip_range_start_ip_address" {
  description = "starting ip address which should allow connection to database"
  type = string
}

variable "truefoundry_db_allowed_ip_range_end_ip_address" {
  description = "starting ip address which should allow connection to database"
  type = string
}

#### Azure Container Repository

variable "create_acr" {
  type        = bool
  description = "Create acr"
  default     = false
}

#### Azure KeyVault

variable "create_kv" {
  type        = bool
  description = "Create kv"
  default     = false
}

#### Azure Storage

variable "create_blob_storage" {
  type        = bool
  description = "Create blob storage"
  default     = false
}

###### mlfoundry

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

###### svcfoundry

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
