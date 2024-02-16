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
  type = map(string)
  description = "A map of NSG names to Network Security Group IDs to enable flow logs for."
}

variable "log_analytics_workspace_id" {
  type        = string
  description = "The ID of the Log Analytics Workspace for traffic analytics."
}

variable "location" {
  type        = string
  description = "The location where the resources are deployed."
}

variable "log_analytics_workspace_resource_id" {
  type        = string
  description = "The resource ID of the Log Analytics Workspace for traffic analytics."
}
