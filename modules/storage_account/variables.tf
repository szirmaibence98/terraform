variable "name" {
  type        = string
  description = "The name of the storage account, must be unique across Azure."
}

variable "resource_group_name" {
  type        = string
  description = "The name of the resource group in which to create the storage account."
}

variable "location" {
  type        = string
  description = "The location/region where the storage account is created."
}

variable "account_tier" {
  type        = string
  description = "Defines the Tier to use for this storage account."
}

variable "account_replication_type" {
  type        = string
  description = "Defines the type of replication to use for this storage account."
}

variable "tags" {
  type        = map(string)
  description = "A mapping of tags to assign to the resource."
  default     = {}
}
