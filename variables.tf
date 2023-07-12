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
  type        = string
  description = "Storage for DB"
}

variable "truefoundry_db_subnet_id" {
  type        = string
  description = "ID of the subnet which the db should use"
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
