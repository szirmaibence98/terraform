variable "network_watcher_name" {
  type        = string
  description = "The name of the Network Watcher."
}

variable "resource_group_name" {
  type        = string
  description = "The name of the resource group."
}

variable "storage_account_id" {
  type        = string
  description = "The ID of the storage account where flow logs are stored."
}

variable "nsg_ids" {
  type        = list(string)
  description = "A list of Network Security Group IDs to enable flow logs for."
}
