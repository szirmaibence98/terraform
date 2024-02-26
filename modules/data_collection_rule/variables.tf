variable "name_prefix" {
  type        = string
  description = "Prefix for the data collection rule name."
}

variable "resource_group_name" {
  type        = string
  description = "The name of the resource group."
}

variable "location" {
  type        = string
  description = "The location of the resource group."
}

variable "data_collection_endpoint_id" {
  type        = string
  description = "The ID of the data collection endpoint."
}

variable "monitor_workspace_id" {
  type        = string
  description = "The ID of the monitor workspace."
}

variable "cluster_name" {
  type        = string
  description = "The name of the cluster."
}