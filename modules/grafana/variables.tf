variable "grafana_name" {
  type        = string
  description = "The name of the Grafana Dashboard."
}

variable "resource_group_name" {
  type        = string
  description = "The name of the resource group."
}

variable "grafana_location" {
  type        = string
  description = "The Azure region where the Grafana Dashboard will be created."
}

variable "azure_monitor_workspace_id" {
  type        = string
  description = "The resource ID of the Azure Monitor Workspace to integrate with Grafana."
}
